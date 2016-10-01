


#Creating Objects

```
class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
}
```

We can create new objects in several ways:

```
// (1) Create a Dog object and then set its properties
var myDog = Dog()
myDog.name = "Rex"
myDog.age = 10

// (2) Create a Dog object from a dictionary
let myOtherDog = Dog(value: ["name" : "Pluto", "age": 3])

// (3) Create a Dog object from an array
let myThirdDog = Dog(value: ["Fido", 5])
```

##Adding Objects

```
// Create a Person object
let author = Person()
author.name = "David Foster Wallace"

// Get the default Realm
let realm = try! Realm()
// You only need to do this once (per thread)

// Add to the Realm inside a transaction
try! realm.write {
  realm.add(author)
}
```

## Retrieving Records

```
specimens = try! Realm().objects(Specimen)
```

##Update

```
func updateSpecimen() {
        let realm = try! Realm()
        try! realm.write {
            self.specimen.name = self.nameTextField.text!
            self.specimen.category = self.selectedCategory
            self.specimen.specimenDescription = self.descriptionTextField.text
        }
    }
```

##Sorted
```
specimens = realm.objects(Specimen).sorted("name", ascending: true)
```

##Fetching With Predicates

```
func filterResultsWithSearchString(searchString: String) {
        let predicate = NSPredicate(format: "name BEGINSWITH [c]%@", searchString)
        let scopeIndex = searchController.searchBar.selectedScopeButtonIndex
        let realm = try! Realm()
        
        switch scopeIndex {
        case 0:
            searchResults = realm.objects(Specimen).filter(predicate).sorted("name", ascending: true)
        case 1:
            searchResults = realm.objects(Specimen).filter(predicate)
.sorted("created", ascending: true)
        default:
            searchResults = realm.objects(Specimen).filter(predicate)
        }
    }
```

##