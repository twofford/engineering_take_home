import React from "react";
import convertToSentenceCase from "../utils/convertToSentenceCase";

const CustomField = (el) => {
  const data = Object.values(el)[0];
  const k = Object.keys(data)[0];
  const v = Object.values(data)[0];

  return (
    <p>
      <strong>{convertToSentenceCase(k)}:</strong> {v}
    </p>
  );
};

export default CustomField;
