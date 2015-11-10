# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0005_auto_20151031_1651'),
    ]

    operations = [
        migrations.AlterField(
            model_name='cliente',
            name='phone',
            field=models.CharField(max_length=16, null=True, verbose_name=b'Telefone fixo', blank=True),
        ),
    ]
