   function vocLocalStorageRemove(key) {
      if (typeof(Storage) === "undefined") {
          console.log("quick mode: not supported");
          return false;
      }
      console.log("clearing key "+ key);
      localStorage.removeItem(key);
      return true;
   }
   function vocLocalStorageKey(type, id) {
       switch (type) {
           case "editasn":
               key = "editasn_" + id;
               return key;
           default:
               console.log("Invalid key. Ignoring. Report to support");
               alert("Invalid key. Ignoring. Report to support");
               return null;
        }           
   }
