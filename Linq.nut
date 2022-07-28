if ("Linq" in getroottable() && typeof ::Linq == "class" )
    return;

class Linq {
    constructor (_arr) {
        if (typeof _arr != "array") 
            throw "Invalid constructor parameter's type. Expected array."

        arr = _arr;
    }

    arr = null;

    Error =  {
        NoMatch = "No match for predicate",
        MoreThanOneMatch = "More than one match",
        DuplicateKeys = "Duplicate keys in array element's attributes"
    }

    function Where(predicate) {
        local result = [];
        for (local i = 0; i < arr.len(); i++) {
            if ( predicate(arr[i]) )
                result.append(arr[i])
        }
        return Linq(result);
    }
    
    function First(predicate = null) {
        if (!predicate) return arr[0]

        for (local i = 0; i < arr.len(); i++) {
            if ( predicate(arr[i]) )
                return arr[i]
        }
        throw Error.NoMatch;
    }
    
    function Last(predicate = null) {
        if (!predicate) return arr.top()

        local result = null;
        local found = false;
    
        foreach (element in arr) {
            if ( predicate(element) ) {
                result = element;
                found = true;
            }
        }
    
        if (found) return result;
    
        throw Error.NoMatch;
    }
    
    function Single(predicate) {
        local result = null;
        local count = 0;
    
        foreach (element in arr) {
            if ( predicate(element) ) {
                result = element;
                count++;
            }
        }
    
        switch (count) {
            case 0: throw Error.NoMatch;
            case 1: return result;
        }
    
        throw Error.MoreThanOneMatch
    }
    
    function Any(predicate = null) {
        if (predicate == null)
            return arr.len() > 0
    
        foreach (element in arr) {
            if ( predicate(element) )
                return true;
        }
    
        return false;
    }
    
    function All(predicate) {
        foreach (element in arr) {
            if ( !predicate(element) )
                return false;
        }
        return true;
    }

    function Contains(value) {
        foreach (element in arr) {
            if (element == value)
                return true;
        }
        return false;
    }
    
    function OrderBy(propertyName) {
        local result = arr;
        local modified = true;
    
        while (modified) {
    
            modified = false;
    
            for (local i = 0; i < (result.len() - 1); i++) {
    
                local currentVal = result[i];
                local nextVal = result[i + 1];
    
                if (currentVal[propertyName] > nextVal[propertyName]) {
                    result[i] = nextVal;
                    result[i + 1] = currentVal;
                    modified = true;
                }
    
            }
            
        }
    
        return Linq(result);
    }
    
    function OrderByDescending(propertyName) {
        local result = arr;
        local modified = true;
    
        while (modified) {
    
            modified = false;
    
            for (local i = result.len(); i >= 1; i--) {
    
                local currentVal = result[i];
                local nextVal = result[i - 1];
    
                if (currentVal[propertyName] < nextVal[propertyName]) {
                    result[i] = nextVal;
                    result[i - 1] = currentVal;
                    modified = true;
                }
    
            }
            
        }
    
        return Linq(result);
    }

    function Skip(count) {
        return Linq(arr.slice(count))
    }

    function Take(count) {
        arr.resize(count)
        return Linq(arr)
    }

    function Max(propertyName = null) {
        if (!propertyName) {
            arr.sort()
            return arr.top();
        }

        return OrderBy(propertyName).Last()
    }

    function Min(propertyName = null) {
        if (!propertyName) {
            arr.sort()
            return arr[0];
        }

        return OrderBy(propertyName).First()
    }

    function Sum(propertyName = null) {
        local result = 0;

        foreach (element in arr) {
            result += propertyName != null ? element[propertyName] : element
        }

        return result;
    }

    function Average(propertyName = null) {
        return Sum(propertyName) / Count();
    }

    function Count() {
        return arr.len();
    }
    
    function ToTable(keyPropertyName, valuePropertyName = null) {
        local result = {};
    
        foreach (element in arr) {
            local key = element[keyPropertyName];

            if ( key in result )
                throw Error.DuplicateKeys
            
            result[key] <- valuePropertyName == null ? element : element[valuePropertyName];
        }
    
        return result;
    }

    function ToArray() {
        return arr;
    }
}