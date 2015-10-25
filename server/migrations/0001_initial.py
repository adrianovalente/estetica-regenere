# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Area',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=128, verbose_name=b'Nome da area')),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Cliente',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=128, verbose_name=b'Nome Completo')),
                ('email', models.EmailField(max_length=75, verbose_name=b'Email Pessoal')),
                ('phone', models.IntegerField(max_length=16, null=True, verbose_name=b'Telefone fixo', blank=True)),
                ('mobile', models.IntegerField(max_length=16, null=True, verbose_name=b'Telefone celular', blank=True)),
                ('birthDate', models.DateField(null=True, verbose_name=b'Data de Nascimento', blank=True)),
                ('user', models.OneToOneField(null=True, to=settings.AUTH_USER_MODEL)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Consulta',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('day', models.IntegerField(max_length=32, null=True, verbose_name=b'Dia', blank=True)),
                ('month', models.IntegerField(max_length=16, null=True, verbose_name=b'Mes', blank=True)),
                ('year', models.IntegerField(max_length=2048, null=True, verbose_name=b'Ano', blank=True)),
                ('hour', models.IntegerField(max_length=32, null=True, verbose_name=b'Hora', blank=True)),
                ('minute', models.IntegerField(max_length=64, null=True, verbose_name=b'Minuto', blank=True)),
                ('duration', models.IntegerField(max_length=4096, null=True, verbose_name=b'Duracao', blank=True)),
                ('cliente', models.ForeignKey(related_name=b'Cliente', to='server.Cliente')),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Funcionario',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=128, verbose_name=b'Nome do Funcionario')),
                ('area', models.OneToOneField(null=True, to='server.Area')),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Service',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=128, verbose_name=b'Nome do Servico')),
                ('area', models.ForeignKey(related_name=b'Area', to='server.Area')),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.AddField(
            model_name='consulta',
            name='service',
            field=models.ForeignKey(related_name=b'Service', to='server.Service'),
            preserve_default=True,
        ),
    ]
