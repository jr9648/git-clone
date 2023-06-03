<?php
    require_once('teams.php');
    require_once('names.php');
    require_once('commands.php');

    if (!isset($_GET['team']) || !array_key_exists($_GET['team'], $teams)) {
        echo "Random Run: ".rand(101010, 999999)." Tau! Kaun si team ?";
        exit(1);
    }

    if (!isset($_GET['project']) || !array_key_exists($_GET['project'], $teams[$_GET['team']])) {
        echo "Random Run: ".rand(101010, 999999)." Tau! Kaun sa project ?";
        exit(1);
    }

    if (!isset($_GET['repo']) || !in_array($_GET['repo'], $teams[$_GET['team']][$_GET['project']])) {
        echo "Random Run: ".rand(101010, 999999)." Tau! Kaun si repo ?";
        exit(1);
    }

    if (!isset($_GET['command']) || !in_array($_GET['command'], $commands)) {
        echo "Random Run: ".rand(101010, 999999)." Tau! Kaun sa command ?";
        exit(1);
    }

    $command = $_GET['command'];

    echo 'sudo -u ubuntu /home/ubuntu/barelab/build.sh '.
            $_GET['team'].' '.$_GET['project'].' '.$_GET["repo"].' '.$command.' &<br />';
    exec('sudo -u ubuntu /home/ubuntu/barelab/build.sh '.
            $_GET['team'].' '.$_GET['project'].' '.$_GET["repo"].' '.$command.' &', $output, $return_code);

    echo "Random Run: ".rand(101010, 999999)." Return Code: ".$return_code."<br />";
    foreach ($output as $id => $out)
        echo "Line ".($id + 1).": ".$out."<br />";
?>
