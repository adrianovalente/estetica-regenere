# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0002_auto_20150928_2059'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='consulta',
            name='day',
        ),
        migrations.RemoveField(
            model_name='consulta',
            name='duration',
        ),
        migrations.RemoveField(
            model_name='consulta',
            name='hour',
        ),
        migrations.RemoveField(
            model_name='consulta',
            name='minute',
        ),
        migrations.RemoveField(
            model_name='consulta',
            name='month',
        ),
        migrations.RemoveField(
            model_name='consulta',
            name='year',
        ),
        migrations.AddField(
            model_name='consulta',
            name='time',
            field=models.DateTimeField(default=datetime.date(2015, 9, 28), verbose_name=b'Hora'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='service',
            name='duration',
            field=models.IntegerField(default=60, max_length=16, verbose_name=b'Duracao do servico'),
            preserve_default=False,
        ),
    ]
