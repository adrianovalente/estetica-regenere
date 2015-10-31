# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('server', '0004_auto_20151001_1447'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='funcionario',
            name='area',
        ),
        migrations.AddField(
            model_name='area',
            name='funcionario',
            field=models.OneToOneField(null=True, to='server.Funcionario'),
            preserve_default=True,
        ),
    ]
