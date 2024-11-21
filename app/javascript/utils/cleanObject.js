export default function cleanObject(obj) {
  for (const key in obj) {
    const value = obj[key];
    if (
      value === null ||
      (typeof value === "object" &&
        value !== null &&
        Object.keys(value).length === 0)
    ) {
      delete obj[key];
    }
  }
  return obj;
}
