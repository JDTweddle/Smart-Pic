import React from 'react';
import './ImageLinkForm.css';

const ImageLinkForm = ({ onInputChange, onButtonSubmit, onImageUpload }) => {
  return (
    <div>
      <p className="f3">
        {'This app will detect things in your pictures. Give it a try.'}
      </p>
      <div className="center">
        <div className="form center pa4 br3 shadow-5">
          <input
            className="f4 pa2 w-50 center"
            type="text"
            placeholder="Enter image URL"
            onChange={onInputChange}
          />
          <input
            className="b grow f4 pa2 w-25 ph4 grey"
            type="file"
            accept="image/*"
            onChange={onImageUpload}
          />
          <button
            className="b w-30 grow f4 link ph3 pv2 dib white b--orange bg-orange"
            onClick={onButtonSubmit}
          >
            Detect
          </button>
        </div>
      </div>
    </div>
  );
};

export default ImageLinkForm;
