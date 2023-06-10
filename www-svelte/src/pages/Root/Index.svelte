<script lang="ts">
  import { router } from "@inertiajs/svelte";
  import { writable } from "svelte/store";
  import { onMount } from "svelte";

  let time: string;

  const start = writable(null);
  const count = writable(0);
  const currentPageIndex = writable(0);

  onMount(() => {
    const appearTime = new Date().toISOString();
    console.log("View Appear Time", appearTime);
  });

  const handleSwipe = (event: TouchEvent) => {
    const touch = event.touches[0];
    const startX = touch.clientX;

    const handleTouchEnd = (event: TouchEvent) => {
      const touch = event.changedTouches[0];
      const endX = touch.clientX;

      if (startX - endX > 0) {
        // Swipe from right to left
        currentPageIndex.update((index) => (index + 1) % 3);
      } else if (startX - endX < 0) {
        // Swipe from left to right
        currentPageIndex.update((index) => (index - 1 + 3) % 3);
      }

      document.removeEventListener("touchend", handleTouchEnd);
    };

    document.addEventListener("touchend", handleTouchEnd);

    console.log("currentPageIndex", $currentPageIndex);

  };
</script>

<header />

<main on:touchstart={handleSwipe} style="overflow: hidden;">
  {#if $currentPageIndex === 0}
    <div class="page" style="background-color: #007AFE;">
      <h1>Page 1</h1>
      <div class="dot-container">
        <div class="dot activeDot"/>
        <div class="dot"/>
        <div class="dot"/>
      </div>
    </div>
  {:else if $currentPageIndex === 1}
    <div class="page" style="background-color: #FF9500;">
      <h1>Page 2</h1>
      <div class="dot-container">
        <div class="dot" />
        <div class="dot activeDot" />
        <div class="dot" />
      </div>
    </div>
  {:else if $currentPageIndex === 2}
    <div class="page" style="background-color: #35C759;">
      <h1>Page 3</h1>
      <div class="dot-container">
        <div class="dot" />
        <div class="dot" />
        <div class="dot activeDot" />
      </div>
    </div>
  {/if}
</main>

<style>
  main {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;

    font-family: system-ui, -apple-system, sans-serif;
    color: white;
	height: 100vh;
  }

  .page {
    height: 100vh;
    width: 100vw;
    position: absolute;
    top: 0;
    left: 0;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    transition: transform 0.3s ease-in-out;
    will-change: transform;
  }

  .page:nth-child(1) {
    transform: translateX(calc(var(--page-width) * var(--page-index)));
  }

  .page:nth-child(2) {
    transform: translateX(calc(var(--page-width) * (var(--page-index) - 1)));
  }

  .page:nth-child(3) {
    transform: translateX(calc(var(--page-width) * (var(--page-index) - 2)));
  }

  .dot-container {
    display: flex;
    flex-direction: row;
    gap: 10px;
    margin-top: 425px;
  }

  .dot {
    height: 10px;
    width: 10px;
    background-color: white;
    border-radius: 50%;
  }

  .activeDot {
	background-color: rgb(255, 255, 255) !important;
	opacity: 0.5;
  }
</style>
