// @ts-check
import assert from "node:assert";
import fs from "node:fs";
import path from "node:path";
import { describe, it } from "node:test";

// setup.sh executes *.sh in alphabetical order. omz.sh prepends oh-my-zsh config
// to ~/.zshrc, so it must run last — otherwise a later script could overwrite the
// file and push the config block down from the top.
const SETTINGS_DIR = path.join(import.meta.dirname, "../src/settings");

await describe("settings execution order", async () => {
  await it("omz.sh should be the last .sh file in settings/", () => {
    const files = fs
      .readdirSync(SETTINGS_DIR)
      .filter((f) => f.endsWith(".sh"))
      .toSorted();
    const last = files.at(-1);
    assert.strictEqual(last, "omz.sh");
  });
});
