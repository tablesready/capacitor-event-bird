import { CapacitorEventBird } from 'capacitor-event-bird';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    CapacitorEventBird.echo({ value: inputValue })
}
