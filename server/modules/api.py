# External modules
from django.shortcuts import render, HttpResponse, HttpResponseRedirect
from django.views.decorators.csrf import csrf_exempt
import json
from server.models import *
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from jose import jws

# Internal modules
from agenda import *
from aux import *

@csrf_exempt
def signup(request):

    body = json.loads(request.body)
    print body
    responseObject = {}
    try:
        code = int(body['code'])
    except:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'CODE_NOT_VALID'}
        return HttpResponse(json.dumps(responseObject), content_type="application/json")

    if (User.objects.filter(username = body['email']).count() > 0):
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'EMAIL_ALREADY_USED'}
        return HttpResponse(json.dumps(responseObject), content_type="application/json")

    if (verificationCodeIsValid(body['email'], code)):
        if Cliente.objects.filter(email = body['email']).count() > 0:
            user = User.objects.create_user(body['email'], body['email'], body['password'])
            user.save()
            cliente = Cliente.objects.get(email = body['email'])
            cliente.user = user
            cliente.save()

            responseObject['isSuccess'] = 1
            responseObject['content'] = {"id": user.id}

        else:
            responseObject["isSuccess"] = 0
            responseObject['content'] = {'error': 'NOT_A_CLIENT'}

    else:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'CODE_NOT_VALID'}

    return HttpResponse(json.dumps(responseObject), content_type="application/json")

@csrf_exempt
def login(request):
    body = json.loads(request.body)

    user = authenticate(username=body['email'], password=body['password'])
    responseObject = {}
    if user is not None:
        responseObject["isSuccess"] = 1
        responseObject['content'] = {'token': jws.sign({'username': user.username}, 'secret', algorithm='HS256')}
    else:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'AUTH_FAILED'}

    return HttpResponse(json.dumps(responseObject), content_type="application/json")

def home(request):
    token = request.META.get('HTTP_REGENERETOKEN')
    responseObject = {}

    if token is None:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'TOKEN_MISSING'}
        return HttpResponse(json.dumps(responseObject), content_type="application/json")

    try:
        verified = jws.verify(token, 'secret', algorithms=['HS256'])

    except:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'AUTH_FAILED'}
        return HttpResponse(json.dumps(responseObject), content_type="application/json")

    username = verified['username']
    user = User.objects.get(username=username)
    cliente = Cliente.objects.get(user=user)
    responseObject["isSuccess"] = 1
    responseObject['content'] = {}
    responseObject['content']['name'] = cliente.name
    responseObject['content']['consultas'] = getConsultas(cliente)

    return HttpResponse(json.dumps(responseObject), content_type="application/json")


def getAreas(request):
    responseObject = {}
    responseObject['isSuccess'] = 1
    responseObject['content'] = {}
    responseObject['content']['areas'] = []
    for area in Area.objects.all():
        areaObj = {}
        areaObj['name'] = area.name
        areaObj['id'] = area.id
        responseObject['content']['areas'].append(areaObj)
    return HttpResponse(json.dumps(responseObject), content_type="application/json")

def getServicesForArea(request, id_area):
    responseObject = {}
    responseObject['isSuccess'] = 1
    responseObject['content'] = {}
    responseObject['content']['services'] = []
    for service in Service.objects.filter(area = Area.objects.get(id = id_area)):
        serviceObj = {}
        serviceObj['name'] = service.name

        serviceObj['id'] = service.id
        responseObject['content']['services'].append(serviceObj)
    return HttpResponse(json.dumps(responseObject), content_type="application/json")

def getAvaliableDaysForService(request, id_service):

    # Auth logic
    token = request.META.get('HTTP_REGENERETOKEN')
    responseObject = {}

    if token is None:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'TOKEN_MISSING'}
        return HttpResponse(json.dumps(responseObject), content_type="application/json")

    try:
        verified = jws.verify(token, 'secret', algorithms=['HS256'])

    except:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'AUTH_FAILED'}
        return HttpResponse(json.dumps(responseObject), content_type="application/json")

    username = verified['username']
    user = User.objects.get(username=username)
    cliente = Cliente.objects.get(user=user)


    today = datetime.today()
    times = []
    for i in range (1, MAX_DAYS):
        date = today + timedelta(days = i)
        for time in getTimes(Service.objects.get(id = id_service), cliente, date.day, date.month, date.year):
            addTimeToArray(time, times)

    responseObject = {}
    responseObject["isSuccess"] = 1
    responseObject["contents"] = {}
    responseObject["contents"]["dates"] = times

    return HttpResponse(json.dumps(responseObject), content_type="application/json")

def getAvaliableDaysForServiceWithClient(request, id_service, id_client):

    cliente = Cliente.objects.get(id=id_client)
    today = datetime.today()
    times = []
    for i in range (1, MAX_DAYS):
        date = today + timedelta(days = i)
        for time in getTimes(Service.objects.get(id = id_service), cliente, date.day, date.month, date.year):
            addTimeToArray(time, times)

    responseObject = {}
    responseObject["isSuccess"] = 1
    responseObject["contents"] = {}
    responseObject["contents"]["dates"] = times

    return HttpResponse(json.dumps(responseObject), content_type="application/json")

def deleteAppointment(request, id_appointment):

    # Auth logic
    token = request.META.get('HTTP_REGENERETOKEN')
    responseObject = {}

    if token is None:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'TOKEN_MISSING'}
        return HttpResponse(json.dumps(responseObject), content_type="application/json")

    try:
        verified = jws.verify(token, 'secret', algorithms=['HS256'])

    except:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'AUTH_FAILED'}
        return HttpResponse(json.dumps(responseObject), content_type="application/json")

    username = verified['username']
    user = User.objects.get(username=username)
    cliente = Cliente.objects.get(user=user)

    # Delete logic
    if (Consulta.objects.filter(id = id_appointment).count() > 0):
        consulta = Consulta.objects.get(id = id_appointment)
        if (consulta.cliente == cliente):
            consulta.delete()
            responseObject = {}
            responseObject["isSuccess"] = 1
            responseObject["contents"] = {}
        else:
            responseObject = {}
            responseObject["isSuccess"] = 0
            responseObject["contents"] = {'error': 'NOT_AUTHORIZED'}
    else:
        responseObject = {}
        responseObject["isSuccess"] = 0
        responseObject["contents"] = {'error': 'NOT_FOUND'}

    return HttpResponse(json.dumps(responseObject), content_type="application/json")

@csrf_exempt
def scheduleAppointment(request):

    # Auth logic
    token = request.META.get('HTTP_REGENERETOKEN')
    responseObject = {}

    if token is None:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'TOKEN_MISSING'}
        return HttpResponse(json.dumps(responseObject), content_type="application/json")

    try:
        verified = jws.verify(token, 'secret', algorithms=['HS256'])

    except:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'AUTH_FAILED'}
        return HttpResponse(json.dumps(responseObject), content_type="application/json")

    username = verified['username']
    user = User.objects.get(username=username)
    cliente = Cliente.objects.get(user=user)

    body = json.loads(request.body)

    service = Service.objects.get(id = body["service"])
    dateTimeValues = body["time"].split("-")

    date = datetime(int(dateTimeValues[2]), int(dateTimeValues[1]), int(dateTimeValues[0]), int(dateTimeValues[3].split(":")[0]), int(dateTimeValues[3].split(":")[1]), 0)
    if timeIsAvailable(service, cliente, date):
        consulta = Consulta()
        consulta.cliente = cliente
        consulta.service = service
        consulta.time = date
        consulta.save()
        responseObject["isSuccess"] = 1
        return HttpResponse(json.dumps(responseObject), content_type="application/json")
    else:
        responseObject["isSuccess"] = 0
        responseObject['content'] = {'error': 'TIME_NOT_AVAILABLE'}
        return HttpResponse(json.dumps(responseObject), content_type="application/json")

def aboutMe(request):
    return HttpResponseRedirect("https://github.com/adrianovalente")
