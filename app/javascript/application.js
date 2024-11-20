import React, { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import Root from "./components/Root";

document.addEventListener("DOMContentLoaded", () => {
  const node = document.getElementById("react-root");
  if (node) {
    const root = createRoot(node);
    root.render(
      <StrictMode>
        <Root />
      </StrictMode>
    );
  }
});
