<script lang="ts">
  import { router } from "@inertiajs/svelte";
  import { writable } from "svelte/store";

  export let images: string;

  //   const start = writable(null);

  const takePicture = () => {
    router.get("/takePicture");

    router.get("/getImages");
    console.log(images);
  };

  document.addEventListener("visibilitychange", () => {
    if (document.visibilityState === "visible") {
      router.get("/");
      console.log(images)
    }
  });

  // router.on("success", (event) => {
  //   router.get("/");
  // });
</script>

<header />

<main>
  <h1>Camera - Feature</h1>
  <button on:click={takePicture}>Kamera öffnen</button>

  {#if images}
  <img src="data:image/jpeg;base64,{images}" alt="Bild" />
  {/if}
</main>

<style>
  main {
    font-family: system-ui, -apple-system, sans-serif;
  }

  button {
    all: unset;
    padding: 14px;
    font-family: system-ui, -apple-system sans-serif;
    font-size: 18px;
    background-color: black;
    color: white;
    border-radius: 8px;
  }
</style>
