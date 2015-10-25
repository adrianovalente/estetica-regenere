from django.shortcuts import render, HttpResponse
from server.models import *

def getVerificationCodeFromEmail(email):
    username = email.split("@")[0]
    count = 0
    i = 1
    for char in username:
        count += i*ord(char)
        i+=1
    verificationCode = count % 1000
    if verificationCode < 1000:
        verificationCode += 1000
    return verificationCode

def verificationCodeIsValid(email, code):
    return code == getVerificationCodeFromEmail(email)

def emailIsAlreadyUsed(email):
    return Cliente.objects.filter(email = email).count() > 0

def error(message):
    return HttpResponse("<script langauge = 'javascript'>alert('" + message +  "'); window.location.href = 'javascript:history.back()';</script>")

def success(message, redir):
    return HttpResponse("<script langauge = 'javascript'>alert('" + message +  "'); window.location.href = '" + redir + "';</script>")

def emailIsValid(email):
    if (len(email.split("@")) < 2):
        return False
    if (len(email.split("@")[1].split("."))) < 2:
        return False
    if (email.split("@")[1].split(".")[1] == ""):
        return False
    return True
