from django.db import models
from django.contrib.auth.models import User

class Cliente(models.Model):
    name = models.CharField("Nome Completo", max_length=128)
    address = models.CharField("Endereco", max_length=256)
    email= models.EmailField("Email Pessoal")
    phone = models.IntegerField("Telefone fixo", max_length=16, blank=True, null=True)
    mobile = models.IntegerField("Telefone celular", max_length=16, blank=True, null=True)
    user = models.OneToOneField(User, null=True)
    birthDate = models.DateField("Data de Nascimento", blank=True, null=True)

    def __unicode__(self):
        return self.name

class Area(models.Model):
    name = models.CharField("Nome da area", max_length=128)
    startTime = models.IntegerField("Hora de inicio do trabalho", max_length=16, blank=True, null=True)
    endTime = models.IntegerField("Hora de final do trabalho", max_length=16, blank=True, null=True)


    def __unicode__(self):
        return self.name

class Service(models.Model):
    name = models.CharField("Nome do Servico", max_length=128)
    area = models.ForeignKey('Area', related_name='Area')
    duration = models.IntegerField("Duracao do servico", max_length=16)

    def __unicode__(self):
        return self.name

class Funcionario(models.Model):
    name = models.CharField("Nome do Funcionario", max_length=128)

    # TODO: Remodel this link to be smarter in the future!
    area = models.OneToOneField('Area', null=True)
    user = models.OneToOneField(User, null=True)

    def __unicode__(self):
        return self.name

class Consulta(models.Model):
    cliente = models.ForeignKey('Cliente', related_name='Cliente')
    service = models.ForeignKey('Service', related_name='Service')
    time = models.DateTimeField("Hora")

    def __unicode__(self):
        return self.cliente.name + " - " + self.service.name
