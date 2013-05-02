CSBus(Nome temporário)
=====

Esse projeto foi criado pelo fato de que o site da empresa não fornecia uma api acessível e amigável que permitisse acessar informação como horários e destinos de vários ônibus, e optei pelo framework Sinatra devido a simplicidade de lidar com com a arquitetura REST , fornecendo esses dados tanto em json e xml.

*URLs* disponiveis:<br/>
GET **/trips.json** : retorna a listagem com todas a informações no formato json.<br/>
GET **/trips.xml** : retorna a listagem com todas a informações no formato xml.<br/>
