*{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

header{
    height: 25vh;
    width: 100vw;
    background-color: black;
    color: white;
}

header h1{
    position: relative;
    text-align: center;
    justify-content: center;
    top: 40%;
    transform: translate(0,-50%);
    font-size: calc(2vw + 2em);
    font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
}

header a{
    position: relative;
    text-decoration: none;
    color: white;
    left: 20px;
    top: 20px;
    font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
    font-size: calc(0.5vw + 1em);
}

.zone-sommaire{
    padding-top: 50px;
    padding-bottom: 50px;
    display: flex;
    justify-content: center;
    width: 100vw;
    height: auto;
    background-color: grey;
}

.cadre-sommaire{
    width: 70%;
    padding: 20px 50px;
    background-color: rgba(255, 0, 0, 0.13);
    border: black 3px solid;
    border-radius: 5px;
    font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
}

.cadre-sommaire h1{
    text-align: center;
    font-size: 3em;
    margin-bottom: 15px;
}

.cadre-sommaire h2{
    cursor: pointer;
    text-decoration: underline;
    font-size: 2em;
    margin-bottom: 10px;
    margin-top: 20px;
    transition: 0.6s;
}

.cadre-sommaire h2:hover{
    transition: 0.6s;
    color: #3e6ae1;
}