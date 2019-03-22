<?php
/**
 * Script pour inscription des utilisateurs en BDD
 */

// Définition du type MIME du fichier pour retour AJAX
header("Content-type: text/plain");

// RÉCUPÉRATION DES INFORMATIONS DE L'UTILISATEUR -----------------------

$prenom = $_POST["prenom"];
$nom = $_POST["nom"];
$email = $_POST["email"];
$mdp = $_POST["mdp"]; // TODO: hash mdp

// INSERTION DES DONNEES DANS LA BDD -------------------------

// Informations de connexion
$user = "glen";
$pass = getenv("MYSQL_PASS");

try {
    // Ouverture de la connexion
    $bdd = new PDO("mysql:host=localhost;dbname=CLUBTENNIS", $user, $pass);
    // Préparation de l'insertion
    $req = $bdd->prepare("INSERT INTO ABONNE(PRENOM_ABONNE, NOM_ABONNE, EMAIL_ABONNE, MDP_ABONNE) VALUES (?, ?, ?, ?)");
    $req->bindParam(1, $prenom);
    $req->bindParam(2, $nom);
    $req->bindParam(3, $email);
    $req->bindParam(4, $mdp);
    // Execution de l'insertion
    $req->execute();
    if($req) {
        echo "success";
    } else {
        echo "Insertion non réussie";
    }

} catch (Exception $e) {
    echo "Erreur : " . $e->getMessage();
    //die();
} finally {
    // Fermeture de la connexion
    $req = null;
    $bdd = null;
}