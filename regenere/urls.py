from django.conf.urls import patterns, include, url
from django.contrib import admin

urlpatterns = patterns('',

    # Admin
    url(r'^admin/', include(admin.site.urls)),

    # Web interface
    url(r'^$', 'server.views.marcarConsulta'),
    url(r'^clientes/$', 'server.views.clientes'),
    url(r'^excluir_cliente/(?P<id_cliente>[0-9]+)/$', 'server.views.safelyDeleteClient'),
    url(r'^visualizar_cliente/(?P<id_cliente>[0-9]+)/$', 'server.views.visualizar_cliente'),
    url(r'^marcar_consulta/$', 'server.views.marcarConsulta'),
    url(r'^consultas/(?P<id_area>[0-9]+)/$', 'server.views.consultas'),
    url(r'^excluir_consulta/(?P<id_consulta>[0-9]+)/$', 'server.views.excluirConsulta'),
    url(r'^web_login/$', 'server.views.web_login'),
    url(r'^web_logout/$', 'server.views.web_logout'),


    # JSON API
    url(r'^areas/$', 'server.views.getAreas'),
    url(r'^services/(?P<id_area>[0-9]+)/$', 'server.views.getServicesForArea'),
    url(r'^times/(?P<id_service>[0-9]+)/$', 'server.views.getAvaliableDaysForService'),
    url(r'^timeswithclient/(?P<id_service>[0-9]+)/(?P<id_client>[0-9]+)/$', 'server.views.getAvaliableDaysForServiceWithClient'),
    url(r'^signup/$', 'server.views.signup'),
    url(r'^login/$', 'server.views.login'),
    url(r'^home/$', 'server.views.home'),
    url(r'^delete_appointment/(?P<id_appointment>[0-9]+)/$', 'server.views.deleteAppointment'),
    url(r'^schedule/$', 'server.views.scheduleAppointment'),


)
