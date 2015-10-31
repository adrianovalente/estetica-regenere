from server.models import *
from datetime import *

MAX_DAYS = 10
MINUTES_INTERVAL = 15

def addTimeToArray(time, times):
    dateKey = getKeyForDate(time)
    for date in times:
        if date["date"] == dateKey:
            date["times"].append(getKeyForTime(time))
            return

    newDate = {}
    newDate["date"] = dateKey
    newDate["times"] = [getKeyForTime(time)]
    times.append(newDate)

def getKeyForTime(time):
    return "%02d:%02d" % (time.hour, time.minute)

def getKeyForDate(date):
    return "%02d-%02d-%04d" % (date.day, date.month, date.year)

def timeIsAvailable(service, cliente, time):

    WEEKEND = 4
    START_TIME = service.area.startTime
    END_TIME = service.area.endTime

    if time.weekday() > 4:
        return False
    if time.hour > END_TIME or time.hour < START_TIME:
        return False

    consultas = []
    allConsultas = Consulta.objects.all()


    # TODO: Find a smarter way to query this  O__o
    for consulta in allConsultas:
        if (consulta.cliente == cliente):
            consultas.append(consulta)
        else:
            if (consulta.service.area == service.area):
                if (consulta.time.year == time.year):
                    if (consulta.time.month == time.month):
                        if (consulta.time.day == time.day):
                            consultas.append(consulta)


    for consulta in consultas:
        if twoTimesAreConfiltant(time, timedelta(minutes=service.duration), consulta.time, timedelta(minutes=consulta.service.duration)):
            return False

    return True

def twoTimesAreConfiltant(a, duration_a, b, duration_b):
    return not ((b + duration_b <= a) or (a + duration_a <= b))

def getTimes(service, cliente, day, month, year):

    START_TIME = service.area.startTime
    END_TIME = service.area.endTime

    startDate = datetime(year, month, day, START_TIME, 0, 0)
    endDate = datetime(year, month, day, END_TIME, 0, 0)
    dt = timedelta(minutes = MINUTES_INTERVAL)
    availableTimes = []

    i = startDate
    while (i <= endDate):
        if timeIsAvailable(service, cliente, i):
            availableTimes.append(i)
        i+=dt

    return availableTimes


def getConsultas(cliente):
    consultas = []
    for consulta in Consulta.objects.filter(cliente = cliente):
        consultaObject = {}
        consultaObject['date'] = {}
        consultaObject['date']['day'] = consulta.time.day
        consultaObject['date']['month'] = consulta.time.month
        consultaObject['date']['year'] = consulta.time.year
        consultaObject['date']['hour'] = consulta.time.hour
        consultaObject['date']['minute'] = consulta.time.minute
        consultaObject['service'] = consulta.service.name
        consultaObject['consultaId'] = consulta.id
        consultas.append(consultaObject)

    return consultas
