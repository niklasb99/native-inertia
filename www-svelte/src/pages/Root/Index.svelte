<script lang="ts">
  import { router } from "@inertiajs/svelte";
  import { writable } from "svelte/store";

  export let longitude: string;
  export let latitude: string;

  const start = writable(null);
  const count = writable(0);
  const runtimeInSeconds = writable(0);
  const speed = writable(0);

  let oldLON = longitude;
  let oldLAT = latitude;

  let intervalId;
  let startTime: number = 0;
  let endTime: number = 0;

  const startGPS = () => {
    count.set(0);
    start.set(1);
    router.get("/");
    runtimeInSeconds.set(0);
    speed.set(0);
    startTime = Date.now();
  };

  const stopGPS = () => {
    start.set(null);
    count.set(0);
    clearInterval(intervalId);

    oldLON = "0";
    oldLAT = "0";

    longitude = "0";
    latitude = "0";

    runtimeInSeconds.set(0);
    speed.set(0);
  };

  router.on("success", (event) => {
    if ($start) {
      clearInterval(intervalId);
      intervalId = setInterval(() => {
        count.set($count + 1);

        endTime = Date.now();
        runtimeInSeconds.set((endTime - startTime) / 1000);

        router.get("/");

        let lon2 = longitude;
        let lat2 = latitude;

        let distancePerSecond = calculateDistance(oldLAT, oldLON, lat2, lon2);

        if ($count > 1) {
          speed.set(distancePerSecond * 3.6); // (m/s * 3.6 = km/h)
        }
      }, 1000);
    }
  });

  function calculateDistance(lat1, lon1, lat2, lon2) {
    const earthRadius = 6371e3; // Radius der Erde in Metern

    // Umrechnung von Grad in Radianten
    const φ1 = (lat1 * Math.PI) / 180;
    const φ2 = (lat2 * Math.PI) / 180;
    const Δφ = ((lat2 - lat1) * Math.PI) / 180;
    const Δλ = ((lon2 - lon1) * Math.PI) / 180;

    // Haversine-Formel
    const a =
      Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
      Math.cos(φ1) * Math.cos(φ2) * Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    // Distanz in Metern
    const distance = earthRadius * c;

    oldLON = longitude;
    oldLAT = latitude;

    return distance;
  }
</script>

<header />

<main>
  <h1>GPS-Koordinaten</h1>

  <div>
    <button on:click={startGPS}>Start!</button>
    <button on:click={stopGPS}>Stop!</button>
  </div>
  <br />

  <table>
    <tbody>
      <tr>
        <td><h4>Longitude</h4></td>
        <td>{longitude}</td>
      </tr>
      <tr>
        <td><h4>Latitude</h4></td>
        <td>{latitude}</td>
      </tr>
      <tr>
        <td><h4>Runtime</h4></td>
        <td>{$runtimeInSeconds.toFixed(1)} sec.</td>
      </tr>
      <tr>
        <td><h4>Anzahl Responses</h4></td>
        <td>{$count}</td>
      </tr>
      <tr>
        <td><h4>Geschwindigkeit</h4></td>
        <td>{$speed.toFixed(2)} km/h</td>
      </tr>
    </tbody>
  </table>
</main>

<style>
  main {
    font-family: system-ui, -apple-system, sans-serif;
  }

  button {
    all: unset;
    padding: 15px 30px;
    font-family: system-ui, -apple-system sans-serif;
    font-size: 18px;
    background-color: black;
    color: white;
    border-radius: 4px;
  }

  td {
    padding-right: 25px;
  }
</style>
