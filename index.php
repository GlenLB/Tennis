<?php
/**
 * Routeur
 */

// Inclusion du fichier contenant des fonctions utiles à la gestion des erreurs
require_once "./logic/main.php";

// Récupération de l'URI
$requestURI = $_SERVER["REQUEST_URI"];

/**
 *  Définition de la structure d'une page Html
 */
class Page {
    public $title;
    public $description;
    public $canonical;
    public $h1;
    public function __construct($title, $description, $canonical, $h1) {
        $this->title = $title;
        $this->description = $description;
        $this->canonical = $canonical;
        $this->h1 = $h1;
    }
}

// Routage
switch ($requestURI) {
    case "/":
        // Définition des informations de la page
        // Variables passées au template
        $page = new Page(
            "Club de tennis",
            "Site web du club de tennis",
            "https://" . $_SERVER["HTTP_HOST"] . $requestURI,
            "Club de tennis EarthLoader"
        );
        // Inclusion du template
        include_once("./templates/indexTemplate.php");
        break;
    // Gestion des erreurs 404
    default:
        echo ("Erreur 404 -> page non trouvée.");
        break;
}