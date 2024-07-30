window.addEventListener('message', function (event) {
    eFunc = event.data;

    if (eFunc.action == "show") {
        $("#cashmoney").html('$ ' + eFunc.cash);
        $("#bankmoney").html('$ ' + eFunc.bank);
        $(".statuscontainer").show(); // Show the container when action is "show"
    } else if (eFunc.action == "hide") {
        $(".statuscontainer").hide(); // Hide the container when action is "hide"
    }
});
