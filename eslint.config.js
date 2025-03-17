// TODO: Remove this file
import { Builder } from "fenge/eslint-config";

export default new Builder()
  .enableJavaScript()
  .enablePackageJson({
    omit: ["pkg-json/no-nonstandard-property"],
  })
  .toConfig();
