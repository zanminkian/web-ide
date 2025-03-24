// TODO: Remove this file
import { Builder } from "fenge/eslint-config";

export default new Builder()
  .enableJavaScript()
  .enablePackageJson({
    omit: ["publint/warning", "publint/error"],
  })
  .toConfig();
