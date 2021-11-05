# template1_genuka_mobile

Ritual Cafe

## Getting Started

Ce project est structure comme suit:
   # 1- main.dart 

        qui represente la page principale de l'appli. a son initialisation il recherche la presence eventuelle d'un udilidateur dejas enregistre dans la bdd pour le rediriger ver la page collection. dans le cas contraire la page auth est active

   # 2- bdd.dart 

        qui permet la lecture et l'ecriture de la bdd

   # 3- service.dart

        qui est charger de gerrer les differentes fonctions https utilise ainsi que de gerer 
        les donne devant etrestemporairements stocke 

   # 4- auth.dart

        qui contient le formulaire de connexion et inscription 

   # 5- collection.dart 

        qui affiche la listte de collections

   # 6- viewproduit.dart 

        qui afiche le produit et permet le choix


   # 7- models

        qui represente l'ensembles des object utilise dans l'application.
        ces objet sont pour certains isssu des requetes http

   # 8- decoration.dart
        qui contient le gradient et les decorations utilise sur les imputs

   # NB tout fichier ou widget utilise sont generer chacun par divers fonctions affin de faciliter les modifficatons
