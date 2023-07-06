<script lang="ts">
  import { router } from "@inertiajs/svelte";
  import { onMount } from "svelte";

  export let images: any;

  const getData = () => {
    location.reload();
  };

  const takePicture = () => {
    router.get(`/takePicture`, { preserveScroll: true });
  };

  const deletePicture = (imageId) => {
    router.delete(`/${imageId}`, { preserveScroll: true });
    getData();
  };

  let loadImages = async () => {
    const imageContainer = document.getElementsByClassName("img-container")[0];

    await new Promise((resolve) => setTimeout(resolve, 0)); // Warte kurz, um der Seite Zeit zum Rendern zu geben

    images.forEach((image, index) => {
      const imageDiv = imageContainer.children[index];
      const imageURL = `data:image/png;base64,${image.image}`;
      imageDiv.style.background = `url(${imageURL})`;
	  imageDiv.style.backgroundPosition = "center";
      imageDiv.style.backgroundSize = "cover";
    });
  };

  document.addEventListener("visibilitychange", () => {
    if (document.visibilityState === "visible") {
      getData();
    }
  });

  onMount(() => {
    loadImages();
  });
</script>

<header />

<main>
  <h1>Camera - Feature</h1>
  <button on:click={takePicture}>Kamera öffnen</button>
  <button on:click={getData}>Update</button>

  <div class="img-container">
    {#each images as image}
      <div class="img-item">
        <button on:click={() => deletePicture(image.id)} class="delete-button">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            stroke="white"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="feather feather-trash-2"
          >
            <polyline points="3 6 5 6 21 6" />
            <path
              d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"
            />
            <line x1="10" y1="11" x2="10" y2="17" />
            <line x1="14" y1="11" x2="14" y2="17" />
          </svg>
        </button>
      </div>
    {/each}
  </div>
</main>

<style>
  main {
    font-family: system-ui, -apple-system, sans-serif;
  }

  .img-container {
    margin: 5px;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    gap: 3%;
    row-gap: 10px;
  }

  .img-item {
    width: 31%;
    height: 150px;
    object-fit: cover;
    border-radius: 4px;
    position: relative;
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

  button:hover {
    background-color: rgb(0, 145, 255);
  }

  .delete-button {
    all: unset;
    position: absolute;
    top: 5px;
    right: 5px;
    padding: 5px;
    border-radius: 4px;
    background-color: black;
  }
</style>
