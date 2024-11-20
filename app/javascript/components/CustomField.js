import React, { useState } from "react";
import { TextField } from "@mui/material";
import convertToSentenceCase from "../utils/convertToSentenceCase";

const CustomField = ({ el, idx, isEditView, setFormData }) => {
  const data = el["data"];
  const k = Object.keys(data)[0];
  const v = Object.values(data)[0];

  const [formKey, setFormKey] = useState(k);
  const [formValue, setFormValue] = useState(v);

  if (isEditView) {
    return (
      <span>
        <TextField
          id="outlined"
          label="Custom Field"
          variant="standard"
          defaultValue={k}
          value={formKey}
          onChange={(e) => {
            const newKey = e.target.value;

            setFormKey(newKey);
            setFormData((prevData) => {
              const updatedFields = prevData["custom_fields"].map(
                (field, index) => {
                  if (index === idx) {
                    const currentValue = Object.values(field.data)[0];
                    return {
                      ...field,
                      data: { [newKey]: currentValue },
                    };
                  }
                  return field;
                }
              );

              return { ...prevData, custom_fields: updatedFields };
            });
          }}
        />
        :
        <TextField
          id="outlined"
          variant="standard"
          defaultValue={v}
          value={formValue}
          onChange={(e) => {
            const newValue = e.target.value;

            setFormValue(newValue);
            setFormData((prevData) => {
              const updatedFields = prevData["custom_fields"].map(
                (field, index) => {
                  if (index === idx) {
                    const currentKey = Object.keys(field.data)[0];
                    return {
                      ...field,
                      data: { [currentKey]: newValue },
                    };
                  }
                  return field;
                }
              );

              return { ...prevData, custom_fields: updatedFields };
            });
          }}
        />
      </span>
    );
  } else {
    return (
      <p>
        <strong>{convertToSentenceCase(k)}:</strong> {v}
      </p>
    );
  }
};

export default CustomField;
