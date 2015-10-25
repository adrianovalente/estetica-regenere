# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0003_auto_20150928_1828'),
    ]

    operations = [
        migrations.AddField(
            model_name='area',
            name='endTime',
            field=models.IntegerField(max_length=16, null=True, verbose_name=b'Hora de final do trabalho', blank=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='area',
            name='startTime',
            field=models.IntegerField(max_length=16, null=True, verbose_name=b'Hora de inicio do trabalho', blank=True),
            preserve_default=True,
        ),
    ]
