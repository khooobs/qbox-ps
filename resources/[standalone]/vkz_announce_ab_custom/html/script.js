window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.type === "show") {
        document.getElementById("announcement-text").textContent = data.text;
        document.getElementById("announcement-container").style.display = "block";
    }
    else if (data.type === "hide") {
        document.getElementById("announcement-container").style.display = "none";
    }
});