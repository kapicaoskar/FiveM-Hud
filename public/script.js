$('.settings').fadeOut();

let armorHided = false;
let oxyHided = false
let hidedHud = false
let hidedCarh = false
hudvisible = true
window.addEventListener("message", function (event) {
    switch (event.data.action) {
        case "ShowHud":
            $("#allHud").fadeIn();
            break;
        // nuifix     
        case "nuifix":
            $.post('https://FiveM-Hud/HideHud', JSON.stringify({}));
            $("#allHud").fadeOut();
            break;

        case "UpdateCarHud":
            if (hidedCarh == false) {
                if (event.data.carhud == false) {
                    $(".carhud-right").fadeOut();
                    $(".carhud-left").fadeOut();
                } else {
                    $(".carhud-right").fadeIn();
                    $(".carhud-left").fadeIn();
                    document.querySelector('.speed-p').innerText = event.data.speed
                    document.querySelector('#regionek').innerText = event.data.street
                    document.querySelector('#regionsy').innerText = event.data.street
                    document.querySelector('#regoNo').innerText = event.data.region
                    document.querySelector('.direction-mark').innerText = event.data.direction
                    document.querySelector('.gear-p').innerText = event.data.gearCount
                    $(".fuel-filler").css('height', Math.round(event.data.fuel) + "%");

                    if (event.data.fuel >= 90) {
                        $(".fuel-filler").css('border-bottom-left-radius', "11px");
                        $(".fuel-filler").css('border-bottom-right-radius', "11px");
                    } else {
                        $(".fuel-filler").css('border-bottom-left-radius', "0px");
                        $(".fuel-filler").css('border-bottom-right-radius', "0px");
                    }
                }

            } else {

            }
            break

        case "HudInfo":
            $("#health").css('height', event.data.health + "%");
            $("#armor").css('height', event.data.armour + "%");
            $("#hunger").css('height', Math.round(event.data.hunger / 3.5 - 3) + "%");
            $("#water").css('height', Math.round(event.data.thirst / 3.5 - 3) + "%");
            $("#oxygen").css('height', event.data.breath + "%");

            if (event.data.health >= 90) {
                $("#health").css('border-bottom-left-radius', "11px");
                $("#health").css('border-bottom-right-radius', "11px");
            } else {
                $("#health").css('border-bottom-left-radius', "0px");
                $("#health").css('border-bottom-right-radius', "0px");
            }
            if (event.data.armour >= 90) {
                $("#armor").css('border-bottom-left-radius', "11px");
                $("#armor").css('border-bottom-right-radius', "11px");
            } else {
                $("#armor").css('border-bottom-left-radius', "0px");
                $("#armor").css('border-bottom-right-radius', "0px");
            }

            if (event.data.hunger / 3.5 >= 90) {
                $("#hunger").css('border-bottom-left-radius', "11px");
                $("#hunger").css('border-bottom-right-radius', "11px");
            } else {
                $("#hunger").css('border-bottom-left-radius', "0px");
                $("#hunger").css('border-bottom-right-radius', "0px");
            }
            if (event.data.thirst / 3.5 >= 90) {
                $("#water").css('border-bottom-left-radius', "11px");
                $("#water").css('border-bottom-right-radius', "11px");
            } else {
                $("#water").css('border-bottom-left-radius', "0px");
                $("#water").css('border-bottom-right-radius', "0px");
            }
            if (event.data.breath >= 90) {
                $("#oxygen").css('border-bottom-left-radius', "11px");
                $("#oxygen").css('border-bottom-right-radius', "11px");
            } else {
                $("#oxygen").css('border-bottom-left-radius', "0px");
                $("#oxygen").css('border-bottom-right-radius', "0px");
            }

            if (event.data.breath <= 20) {
                $('#oxygen').fadeOut();
            } else {
                $('#oxygen').fadeIn();
            }
            if (event.data.water <= 20) {
                $('#water').fadeOut();
            } else {
                $('#water').fadeIn();
            }
            if (event.data.hunger <= 20) {
                $('#hunger').fadeOut();
            } else {
                $('#hunger').fadeIn();
            }
            if (event.data.armour <= 20) {
                $('#armor').fadeOut();
            } else {
                $('#armor').fadeIn();
            }
            if (event.data.health <= 20) {
                $('#health').fadeOut();
            } else {
                $('#health').fadeIn();
            }

            if (event.data.voiceLevel == 1.5) {
                $("#voice").css('height', event.data.voiceLevel * 15 + "%");
                $("#voice").css('border-bottom-left-radius', "0px");
                $("#voice").css('border-bottom-right-radius', "0px");
            } else if (event.data.voiceLevel == 3.0) {
                $("#voice").css('height', event.data.voiceLevel * 15 + "%");
                $("#voice").css('border-bottom-left-radius', "0px");
                $("#voice").css('border-bottom-right-radius', "0px");
            } else {
                $("#voice").css('height', event.data.voiceLevel * 17 - 2 + "%");
                $("#voice").css('border-bottom-left-radius', "11px");
                $("#voice").css('border-bottom-right-radius', "11px");
            }
            if (event.data.armour <= 0) {
                $('#armorSquare').fadeOut();
            } else {
                if (armorHided == true) {
                } else {
                    $('#armorSquare').fadeIn();
                }
            }
            if (event.data.breath >= 100) {
                $('#oxygenSquare').fadeOut();
            } else {
                if (oxyHided == true) {
                } else {
                    $('#oxygenSquare').fadeIn();
                }
            }
            if (event.data.talkingStatus == true) {
                $("#voice").css({ 'background-color': 'var(--voiceon)' });
            } else {
                $("#voice").css({ 'background-color': 'var(--voiceoff)' });
            }
            break;

        case "Settings":
            $('.settings').fadeIn();
            break;
        case "hidehjud":
            if (hidedHud == true) {
                document.querySelector('.drag-p').innerText = "Tak"
                oxyHided = true
                armorHided = true;
                $('#oxygenSquare').fadeOut();
                $('#voiceSquare').fadeOut();
                $('#armorSquare').fadeOut();
                $('#healthSquare').fadeOut();
                $('#hungerSquare').fadeOut();
                $('#waterSquare').fadeOut();
                hidedHud = false
            } else {
                document.querySelector('.drag-p').innerText = "Nie"
                oxyHided = false
                armorHided = false;
                $('#oxygenSquare').fadeIn();
                $('#voiceSquare').fadeIn();
                $('#armorSquare').fadeIn();
                $('#healthSquare').fadeIn();
                $('#hungerSquare').fadeIn();
                $('#waterSquare').fadeIn();
                hidedHud = true
            }
            break;

        case "UpdateCarHud3":
            if (event.data.waypointDist == 0) {
                $(".one-con").fadeOut();
            } else {
                $(".one-con").fadeIn();
                document.querySelector('.car-distance').innerText = event.data.waypointDist + " m"
            }
            break
    }

    switch (event.data.najs) {
        case "UpdateCarHud2":
            if (event.data.belt == true) {
                $(".belts-filler").css('height', "100%");
            } else {
                $(".belts-filler").css('height', "0%");
            }
            break
    }
});
$(function () {
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://FiveM-Hud/HideHud', JSON.stringify({}));
            $(".settings").fadeOut();
        }
    };
});


const health = () => {
    const text = $('.health-p').text();
    if (text == "Tak") {
        document.querySelector('.health-p').innerText = "Nie"
        $('#healthSquare').fadeOut();
    } else {
        document.querySelector('.health-p').innerText = "Tak"
        $('#healthSquare').fadeIn();
    }
}




const hunger = () => {
    const text = $('.hunger-p').text();
    if (text == "Tak") {
        document.querySelector('.hunger-p').innerText = "Nie"
        $('#hungerSquare').fadeOut();
    } else {
        document.querySelector('.hunger-p').innerText = "Tak"
        $('#hungerSquare').fadeIn();
    }
}



const thirst = () => {
    const text = $('.water-p').text();
    if (text == "Tak") {
        document.querySelector('.water-p').innerText = "Nie"
        $('#waterSquare').fadeOut();
    } else {
        document.querySelector('.water-p').innerText = "Tak"
        $('#waterSquare').fadeIn();
    }
}

const armor = () => {
    const text = $('.armor-p').text();
    if (text == "Tak") {
        document.querySelector('.armor-p').innerText = "Nie"
        armorHided = true;
        $('#armorSquare').fadeOut();
    } else {
        document.querySelector('.armor-p').innerText = "Tak"
        armorHided = false
        $('#armorSquare').fadeIn();
    }
}

const oxygen = () => {
    const text = $('.oxygen-p').text();
    if (text == "Tak") {
        document.querySelector('.oxygen-p').innerText = "Nie"
        oxyHided = true
        $('#oxygenSquare').fadeOut();
    } else {
        document.querySelector('.oxygen-p').innerText = "Tak"
        oxyHided = false
        $('#oxygenSquare').fadeIn();
    }
}

const voip = () => {
    const text = $('.voip-p').text();
    if (text == "Tak") {
        document.querySelector('.voip-p').innerText = "Nie"
        $('#voiceSquare').fadeOut();
    } else {
        document.querySelector('.voip-p').innerText = "Tak"
        $('#voiceSquare').fadeIn();
    }
}

const drag = () => {
    const text = $('.drag-p').text();
    if (text == "Nie") {
        document.querySelector('.drag-p').innerText = "Tak"
        oxyHided = true
        armorHided = true;
        $('#oxygenSquare').fadeOut();
        $('#voiceSquare').fadeOut();
        $('#armorSquare').fadeOut();
        $('#healthSquare').fadeOut();
        $('#hungerSquare').fadeOut();
        $('#waterSquare').fadeOut();
    } else {
        document.querySelector('.drag-p').innerText = "Nie"
        oxyHided = false
        armorHided = false;
        $('#oxygenSquare').fadeIn();
        $('#voiceSquare').fadeIn();
        $('#armorSquare').fadeIn();
        $('#healthSquare').fadeIn();
        $('#hungerSquare').fadeIn();
        $('#waterSquare').fadeIn();
    }

}

const orientation = () => {
    const text = $('.orientation-p').text();
    if (text == "Pozioma") {
        document.querySelector('.orientation-p').innerText = "Pionowa"
        $('.hud').css('margin-bottom', '400px')
        $('.hud').css('display', 'block')
    } else {
        document.querySelector('.orientation-p').innerText = "Pozioma"
        $('.hud').css('margin-bottom', '0px')
        $('.hud').css('display', 'flex')
    }
}




$(document).ready(function () {
    var hitStartTime = 0;
    var maxHitTime = 2000;
});

const draGer = () => {
    const text = $('.drager-p').text();
    if (text == "Przemieść") {
        document.querySelector('.drager-p').innerText = "Zresetuj"
        var hitStartTime = 0;
        var maxHitTime = 2000;
        Draggable.create(".hud", {
            type: "x,y",
            onDrag: function () {
                if (this.hitTest(".settings") && hitStartTime == 0) {
                    hitStartTime = Date.now();
                    TweenLite.delayedCall(0.2, startCount);
                }
            },
        });
    } else {
        document.querySelector('.drager-p').innerText = "Przemieść"
        $.post('https://FiveM-Hud/HideHud', JSON.stringify({}));
        location.reload();
    }

}


const hideCarh = () => {
    const text = $('.carh-p').text();
    if (text == "Nie") {
        document.querySelector('.carh-p').innerText = "Tak"
        hidedCarh = true
        $('.carhud-right').fadeOut('slow');
        $('.carhud-left').fadeOut('slow');
    } else {
        document.querySelector('.carh-p').innerText = "Nie"
        hidedCarh = false
        $('.carhud-right').fadeIn('slow');
        $('.carhud-left').fadeIn('slow');
    }

}



const fuels = () => {
    const text = $('.fuel-p').text();
    if (text == "Tak") {
        document.querySelector('.fuel-p').innerText = "Nie"
        $('.fuel').fadeOut();
    } else {
        document.querySelector('.fuel-p').innerText = "Tak"
        $('.fuel').fadeIn();
    }
}






const belts = () => {
    const text = $('.belts-p').text();
    if (text == "Tak") {
        document.querySelector('.belts-p').innerText = "Nie"
        $('.belts').fadeOut();
    } else {
        document.querySelector('.belts-p').innerText = "Tak"
        $('.belts').fadeIn();
    }
}

const gears = () => {
    const text = $('.gets-p').text();
    if (text == "Tak") {
        document.querySelector('.gets-p').innerText = "Nie"
        $('.gear').fadeOut();
    } else {
        document.querySelector('.gets-p').innerText = "Tak"
        $('.gear').fadeIn();
    }
}


const mpHes = () => {
    const text = $('.mms-p').text();
    if (text == "Tak") {
        document.querySelector('.mms-p').innerText = "Nie"
        $('.speed-p').fadeOut();
        $('.mph-p').fadeOut();
    } else {
        document.querySelector('.mms-p').innerText = "Tak"
        $('.speed-p').fadeIn();
        $('.mph-p').fadeIn();
    }
}



const namerStir = () => {
    const text = $('.mamDosc').text();
    if (text == "Tak") {
        document.querySelector('.mamDosc').innerText = "Nie"
        $('.map-border').fadeOut();
    } else {
        document.querySelector('.mamDosc').innerText = "Tak"
        $('.map-border').fadeIn();
    }
}



const namerStir2 = () => {
    const text = $('.mamDosc2').text();
    if (text == "Tak") {
        document.querySelector('.mamDosc2').innerText = "Nie"
        $('.three-con').fadeOut();
    } else {
        document.querySelector('.mamDosc2').innerText = "Tak"
        $('.three-con').fadeIn();
    }
}



const namerStir3 = () => {
    const text = $('.mamDosc3').text();
    if (text == "Tak") {
        document.querySelector('.mamDosc3').innerText = "Nie"
        $('.two-con').fadeOut();
    } else {
        document.querySelector('.mamDosc3').innerText = "Tak"
        $('.two-con').fadeIn();
    }
}


const namerStir4 = () => {
    const text = $('.mamDosc4').text();
    if (text == "Tak") {
        document.querySelector('.mamDosc4').innerText = "Nie"
        $('.one-con').fadeOut();
    } else {
        document.querySelector('.mamDosc4').innerText = "Tak"
        $('.one-con').fadeIn();
    }
}