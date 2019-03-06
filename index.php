<?php
/**
 * Routeur
 */

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
            "Earthloader, le club de tennis fait pour tous et toutes."
        );
        // Inclusion du template
        try {
            if(!include_once "./templates/indexTemplate.php") {
                throw new Exception("Template non trouvé.");
            }
        } catch(Exception $e) {
            // TODO créer une fonction pour la gestion correcte des erreurs avec envoi de mail à l'admin et écriture dans un fichier de logs
            echo "Erreur serveur : " . $e->getMessage();
        }
        break;
    // Gestion des erreurs 404
    default:
        echo ("Erreur 404 -> page non trouvée.");
        break;
}
