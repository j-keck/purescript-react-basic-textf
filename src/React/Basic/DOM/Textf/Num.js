"use strict;"

exports.toFixed = function(p) {
    return function(n) {
        return n.toFixed(p);
    }
};
