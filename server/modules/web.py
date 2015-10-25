# External modules
from django.shortcuts import render, HttpResponse
from server.models import *
from datetime import *
import json

# Internal modules
from agenda import *
from aux import *
MAX_DAYS = 10
MINUTES_INTERVAL = 15

def clientes(request):

    menu_option = 1

    if request.method == "GET":
        clientes = Cliente.objects.all()
        clientes_list = []
        odd = True
        print (getVerificationCodeFromEmail("dri9595@gmail.com"))
        for cliente in clientes:
            element = {}
            element['cliente'] = cliente
            element['odd'] = odd
            odd = not odd
            clientes_list.append(element)
        return render(request, "clientes.html", locals())
    else:
        if request.method == "POST":

            if not emailIsValid(request.POST['email']):
                return error("Email invalido.")

            if emailIsAlreadyUsed(request.POST['email']):
                return error("Esse email ja foi utilizado em outro cadastro.")
            cliente = Cliente()
            cliente.name = request.POST['name']
            cliente.email = request.POST['email']
            cliente.phone = request.POST['phone']
            cliente.address = request.POST['address']
            cliente.birthDate = date(int(request.POST['year']), int(request.POST['month']), int(request.POST['day']))
            cliente.save()
            verificationCode = getVerificationCodeFromEmail(cliente.email)
            return success("Cliente cadastrdo com sucesso. Codigo de verificacao: " + str(verificationCode), "/clientes")

def visualizar_cliente(request, id_cliente):
    menu_option = 1
    cliente = Cliente.objects.get(id = id_cliente)
    consultas = Consulta.objects.filter(cliente = cliente)
    consultas_count = consultas.count()
    codigo = getVerificationCodeFromEmail(cliente.email)
    return render(request, "visualizar_cliente.html", locals())

def safelyDeleteClient(request, id_cliente):
    cliente = Cliente.objects.get(id = id_cliente)
    consultas = Consulta.objects.all()
    mayExclude = True
    for consulta in consultas:
        if (consulta.cliente == cliente):
            mayExclude = False
            return error("Esse cliente tem consulta marcada e nao pode ser excluido nesse momento")
    if mayExclude:
        cliente.delete()
        return success("Cliente apagado com sucesso.", "/clientes")

def marcarConsulta(request):
    if (request.method == "GET"):
        menu_option = 0
        clientes = Cliente.objects.all().order_by("name")
        areas = Area.objects.all()
        return render(request, "marcarConsulta.html", locals())
    else:
        if (request.method == "POST"):
            cliente = Cliente.objects.get(id =request.POST["name"])
            service = Service.objects.get(id = request.POST["service"])
            dateTimeValues = request.POST["time"].split("-")

            date = datetime(int(dateTimeValues[2]), int(dateTimeValues[1]), int(dateTimeValues[0]), int(dateTimeValues[3].split(":")[0]), int(dateTimeValues[3].split(":")[1]), 0)
            if timeIsAvailable(service, date):
                consulta = Consulta()
                consulta.cliente = cliente
                consulta.service = service
                consulta.time = date
                consulta.save()
                return success("Consulta marcada com sucesso", "/marcar_consulta")
            else:
                return error("Ops, esse horario ja foi ocupado.")

def getKeyFromConsulta(consultaObject):
    return consultaObject["consulta"].time

def consultas(request, id_area):
    if id_area == "3":
        menu_option = 2
    else:
        menu_option = 3

    consultas = []
    area = Area.objects.get(id = id_area)
    odd = True
    date_to_compare = datetime(datetime.now().year, datetime.now().month, datetime.now().day, 0, 0, 0)
    for consulta in Consulta.objects.all():#filter(time__date > date_to_compare):
        if consulta.time > date_to_compare:
            if (consulta.service.area == area):
                consultaObject = {}
                consultaObject["consulta"] = consulta
                consultaObject["odd"] = odd
                consultaObject["date"] = "%02d-%02d-%04d" % (consulta.time.day, consulta.time.month, consulta.time.year)
                consultaObject["time"] = "%02d:%02d" % (consulta.time.hour, consulta.time.minute)

                consultas.append(consultaObject)
                odd = not odd

    consultas.sort(key = getKeyFromConsulta)

    return render(request, "consultas.html", locals())


def excluirConsulta(request, id_consulta):
    consulta = Consulta.objects.get(id = id_consulta)
    url = "/consultas/" + str(consulta.service.area.id)
    consulta.delete()
    return success("Consulta apagada com sucesso", url)
