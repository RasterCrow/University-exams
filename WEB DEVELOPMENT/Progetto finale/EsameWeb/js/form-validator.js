$.validator.addMethod('regex', function (value, element, param) {
    return this.optional(element) ||
        value.match(typeof param == 'string' ? new RegExp(param) : param);
},
    'Inserisci un valore valido');

$(document).ready(function () {
    $("#signupFrame").validate({
        // Specify validation rules
        rules: {
            userName: {
                required: true,
                regex: /^[a-zA-Z ]+$/,
                minlength: 2
            },
            userSurname: {
                required: true,
                regex: /^[a-zA-Z ]+$/,
                minlength: 2
            }, 
            userEmail: {
                required: true,
                // Specify that email should be validated
                // by the built-in "email" rule
                email: true
            },
            userPassword: {
                required: true,
                regex : /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{5,12}$/
            },
            userDate: "required",
            userCity:{
                required :true,
                minlength : 3,
                regex : /^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$/,
            },
            userStreet: {
                required:true,
                minlength : 5,
                regex : /^[a-zA-Z0-9 ^&)(]{5,}$/,
            },
            userCityShipping:{
                minlength : 3,
                regex : /^[a-zA-Z]+(?:[\s-][a-zA-Z]+)*$/,
            },
            userStreetShipping: {
                minlength : 5,
                regex : /^[a-zA-Z0-9 ^&)(]{5,}$/,
            },
            userCardNum: {
                required: true,
                //creditcard: true
                minlength:16,
                regex : /^[0-9]\d*$/
            },
            userCardCcv: {
                required: true,
                digits: true,
            },
            userCardExp: "required",



        },
        // Specify validation error messages
        messages: {
            userName: {
                required: "Campo obbligatorio",
                minlength: "Inserisci almeno 2 caratteri"
            },
            userSurname: {
                required: "Campo obbligatorio",
                minlength: "Inserisci almeno 2 caratteri"
            },
            userPassword: {
                required: "Campo obbligatorio",
                regex :"La password deve essere lunga min 5 max 12 char e avere almeno 1 numero"
            },
            userEmail: "Inserisci una mail valida",
            userDate:"Campo obbligatorio",
            userCity:{
                required:"Campo obbligatorio",
                minlength:"Inserisci almeno 3 caratteri"
            },
            userStreet:{
                required:"Campo obbligatorio",
                minlength:"Inserisci almeno 5 caratteri"
            },
            userCityShipping:{
                minlength:"Inserisci almeno 3 caratteri"
            },
            userStreetShipping:{
                minlength:"Inserisci almento 5 caratteri"
            },
            userCardNum : {
                required : "Campo obbligatorio",
                minlength : "Devi inserire almeno 16 caratteri",
                regex : "Carta non valida"
            },
            userCardCcv:{
                required : "Campo obbligatori",
                digits : "Inserisci solo cifre"
            },
            userCardExp : "Campo obbligatorio"
        },
        // Make sure the form is submitted to the destination defined
        // in the "action" attribute of the form when valid
        submitHandler: function (form) {
            form.submit();
        }
    });
});