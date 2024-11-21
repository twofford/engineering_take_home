export default function filterObject(obj) {
  const result = {};
  Object.entries(obj).forEach(([key, value]) => {
    if (key !== null && value !== null) {
      result[key] = value;
    }
  });
  return result;
}
