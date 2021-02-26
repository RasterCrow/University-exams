$.validator.addMethod('regex', function (value, element, param) {
    return this.optional(element) ||
        value.match(typeof param == 'string' ? new RegExp(param) : param);
},
    'Inserisci un valore valido');

$(document).ready(function () {
    $(".item").validate({
        // Specify validation rules
        rules: {
            name: {
                required: true,
                regex: /^[a-zA-Z0-9^&)(:;,@? ]+$/,
                minlength: 2
            },
            regista: {
                required: true,
                regex: /^[a-zA-Z ]+$/,
                minlength: 2
            },
            autore: {
                required: true,
                regex: /^[a-zA-Z ]+$/,
                minlength: 2
            },  
            descrizione: {
                required: true,
                regex: /^[a-zA-Z0-9^&)(:;,\.@'!-? ]+$/,
                minlength: 20
            },
            userPassword: {
                required: true,
                regex : /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,12}$/
            },
        },
        // Specify validation error messages
        messages: {
            name: {
                required: "Campo obbligatorio",
                minlength: "Inserisci almeno 2 caratteri"
            },
            regista: {
                required: "Campo obbligatorio",
                minlength: "Inserisci almeno 2 caratteri"
            },
            autore: {
                required: "Campo obbligatorio",
                minlength: "Inserisci almeno 2 caratteri"
            },
            descrizione: {
                required: "Campo obbligatorio",
                minlength :"Inserisci almeno 20 caratteri e al massimo 500"
            },
        },
        // Make sure the form is submitted to the destination defined
        // in the "action" attribute of the form when valid
        submitHandler: function (form) {
            form.submit();
        }
    });
    //Questo validator vale per tutti i div con classi particolari
    $(".attore").rules("add", { 
        regex: /^[a-zA-Z ]+$/,
        minlength: 2
      });
    $(".canzoneOra").rules("add", { 
        regex: /^\d{2}+:\d{2}:\d{2}$/
      });
    $(".canzoneTitolo").rules("add", { 
        regex: /^[a-zA-Z0-9 ^&)(:;,@?]+$/,
        minlength: 1
      });
      
});