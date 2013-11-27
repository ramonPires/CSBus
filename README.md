[![Build Status](https://travis-ci.org/ramonPires/CSBus.png?branch=master)](https://travis-ci.org/ramonPires/CSBus)

CSBus(Nome temporário)
=====
Esse projeto foi criado pelo fato de que o site de empresa Costa Sul ,responsável pelo transporte inter-municipal em alguns municípios do sul do Espirito Santo,não fornecia uma api que permitisse acessar informações como horários e rotas dos ônibus,
e optei pelo framework Sinatra devido a simplicidade de lidar com com a arquitetura REST , fornecendo esses dados tanto em json e xml.

*URLs* disponiveis:<br/>
GET **/routes.json** : retorna a listagem com todas a informações no formato json.<br/>
Esse é o link do [serviço ](http://csbus.herokuapp.com/) no heroku.