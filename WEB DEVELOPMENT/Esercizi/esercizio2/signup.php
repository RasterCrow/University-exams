<?php include("top.html"); ?>

<form action="/esercizio2/signup-submit.php" method="post">
    <fieldset>
        <legend>New User Signup:</legend>

        <ul>
            <li>
                <label class="left" for="name">Name:</label>
                <input type="text" name="name" id="name" size="16"><br>
            </li>
            <li>
                <label class="left" for="gender">Gender:</label>
                Female <input type="radio" name="gender" id="female" value="F" checked>
                Male <input type="radio" name="gender" id="male" value="M"><br>
            </li>
            <li>
                <label class="left" for="age">Age:</label>
                <input type="text" name="age" id="age" maxlength="2" size="6"><br>
            </li>
            <li>
                <label  class="left" for="personality">Personality:</label>
                <input type="text" name="personality" id="personality" maxlength="4" size="6">
                (<a href="https://www.humanmetrics.com/cgi-win/jtypes2.asp"> non conosci il tuo tipo?</a>)<br>
            </li>
            <li>
                <label class="left" for="favos">Favorite OS:</label>
                <select name="favos">
                    <option value="Windows">Windows</option>
                    <option value="Mac OS X">MacOS</option>
                    <option value="Linux" selected>Linux</option>
                </select><br>
            </li>
            <li>
                <label class="left">Seeking Age:</label>
                <input type="text" name="minSeekingAge" id="minSeekingAge" maxlength="2" size="6" placeholder="min">
                to <input type="text" name="maxSeekingAge" id="maxSeekingAge" maxlength="2" size="6" placeholder="max"><br>

            </li>
        </ul>
        <input type="submit" value="Sign Up">

    </fieldset>
</form>
<?php include("bottom.html"); ?>