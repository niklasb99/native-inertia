<script lang="ts">
  import { router } from "@inertiajs/svelte";
  import { writable } from "svelte/store";

  import Compass from "../../assets/compass.png";

  export let degree: string;

  let startTime: number = 0;
  let endTime: number = 0;
  const runtimeInSeconds = writable(0);

  const runCompass = writable(null);
  const responseCounter = writable(0);
  const updateCounter = writable(0);
  const start = writable(null);

  let intervalId;

  const startCompass = () => {
    startTime = Date.now();
	runtimeInSeconds.set(0);
    runCompass.set(1);
    startRotation();
    responseCounter.set(0);
	updateCounter.set(0);

    router.get("/");
  };

  const stopCompass = () => {
    runCompass.set(null);
    endTime = Date.now();
    runtimeInSeconds.set((endTime - startTime) / 1000);
	clearInterval(intervalId);
  };

  router.on("success", (event) => {
    if ($runCompass) {
      router.get("/");
      responseCounter.set($responseCounter + 1);
    }
  });

  function startRotation() {
    clearInterval(intervalId);
    intervalId = setInterval(() => {
      const compass = document.getElementById("compass");
      compass.style.transform = `rotate(${degree}deg)`;
	  updateCounter.set($updateCounter + 1);

    }, 8);
  }
</script>

<header />

<main>
  <h2 class="degree">{Math.round(degree)}°</h2>

  <div class="fixpunkt-top" />

  <div class="compass1">
    <img src={Compass} id="compass" alt="compass" />
  </div>

  <div class="button-container">
    <button on:click={startCompass}>Start Compass</button>

    <button on:click={stopCompass}>Stop Compass</button>
  </div>

  <div class="statistic-container">
    <div>Laufzeit des Kompass: <b>{$runtimeInSeconds.toFixed(2)}</b> sec.</div>
    <br />

    <div><b>Bildaktualisierungen seit Start</b></div>
    <div>Insgesamt: <b>{$updateCounter}</b></div>
    <div>Pro Sekunde: <b>{$runtimeInSeconds != 0 ? ($updateCounter / $runtimeInSeconds).toFixed(1) : 0.0}</b></div>
    <br />

    <div><b>Responses seit Start</b></div>
    <div>Insgesamt: <b>{$responseCounter}</b></div>
    <div>Pro Sekunde: <b>{$runtimeInSeconds != 0 ? ($responseCounter / $runtimeInSeconds).toFixed(1) : 0.0}</b></div>
  </div>
</main>

<style scoped>
  main {
    font-family: system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
  }

  .fixpunkt-top {
    border: 3px solid black;
    height: 40px;
    width: 0;
    position: absolute;
    top: 20px;
  }

  .compass1 {
    border: 5px;
    border-color: black;
    border-style: dotted;
    height: 250px;
    width: 250px;
    border-radius: 50%;

    position: absolute;
    top: 80px;

    display: flex;
    justify-content: center;
    align-items: center;
  }

  img {
    height: 225px;
    width: 225px;
  }

  .degree {
    position: absolute;
    top: 330px;
    font-size: 40px;
  }

  button {
    all: unset;
    padding: 15px;
    background-color: black;
    color: white;
    border-radius: 4px;
    width: max-content;
  }

  .button-container {
    position: absolute;
    top: 430px;
    font-weight: 300;
    font-size: 18px;
  }

  .statistic-container {
    position: absolute;
    top: 510px;
    font-weight: 400;
    font-size: 15px;
    margin-left: -70px;
  }
</style>
