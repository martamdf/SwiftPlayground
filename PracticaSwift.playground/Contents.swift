import UIKit

// MARK: - EJERCICIO 1 -
// Calcular y generar una lista con los 100 primeros números primos y hacer un
// print de los últimos 10.

var numerosPrimos = [Int]()
numerosPrimos.append(contentsOf: [1,2])

var n = 3
var esPrimo: Bool
while numerosPrimos.count < 100{
    esPrimo = true;
    for i in 2...n-1{
        if (n%i) == 0{
            esPrimo = false
            break
        }
    }
    if esPrimo == true {
        numerosPrimos.append(n)
    }
    n = n+1
}

//Pra hacer un print de los últimos 10 (dos opciones):
print(numerosPrimos.reversed()[0...9])
print(numerosPrimos.suffix(10))



// MARK: - EJERCICIO 2-
// Calcular la suma de los primeros 50 números primos y hacer un print del resultado.-

var result = numerosPrimos[0...49].reduce(0, +)
print(result)


// MARK: - EJERCICIO 3-
// Dada la siguiente lista, obtener todos los elementos que contengan más de dos vocales:
//val players: [String] = [“Vinicius”, “Messi”, “Ronaldo”, “Pedri”, “Mbappe”, “Modric”, “Militao”, “Morata”, “Valverde”, “Benzema”, “Piqué” ]

var players: [String] = ["Vinicius", "Messi", "Ronaldo", "Pedri", "Mbappe", "Modric", "Militao", "Morata", "Valverde", "Benzema", "Piqué" ]

func VowelsCounter(name : String) -> Bool {
    var vocals: [String] = ["A", "E", "I", "O", "U"]
    var counter = 0
    
    name.forEach { char in
        if vocals.contains(char.uppercased()){
            counter = counter + 1
        }
    }
    if counter > 2{
        return true
    } else{
        return false
    }
}

var playersFiltered = players.filter { player in
    VowelsCounter(name: player)
    }
print(playersFiltered)

// Otro modo con regex
var playersFiltered2 = players.filter { player in
    let range2 = NSRange(location: 0, length: player.utf16.count)
    var regex2 = try? NSRegularExpression(pattern: "(\\w*[aeuioAEIOU]\\w*){3,}")
    return regex2?.firstMatch(in: player, options:[], range: range2) != nil
    }
print(playersFiltered2)
print(players)



// MARK: - EJERCICIO 4 -
// Crear un enumerado que permita indicar la posición en el campo de un jugador de fútbol, por ejemplo: Portero, Lateral Derecho, Central, Lateral Izquierdo, Mediocentro, Extremo Derecha, Extremo Izquierda, Delantero, etc

enum PlayerPosition {
    case portero
    case lateralDerecho
    case central
    case lateralIzquierdo
    case medioCentro
    case extremoDerecho
    case extremoIzquierdo
    case delantero
}

// MARK: - EJERCICIO 5 -
// Crear una clase, con los atributos necesarios, para representar a los miembros que participan en una selección del mundial y un enumerado que los diferencie por tipo, por ejemplo: Jugador, Seleccionador, Médico, etc.

class StaffMember {
    var name: String = "" // propiedad pública
    var type: MemberType // propiedad pública
    
    init(type: MemberType) {
        self.type = type // Inicializo por defecto como jugador
    }
}

// Puede ser que no sea necesaria... revisar
class Player : StaffMember {
    var posicion : PlayerPosition
    init(name: String, type: MemberType, posicion: PlayerPosition) {
        self.posicion = posicion
        super.init(type: type)
    }
}

enum MemberType {
    case jugador
    case seleccionador
    case preparador
    case medico
}

// MARK: - EJERCICIO 6 -
// Crear las clases necesarias, con los atributos mínimos, para representar las selecciones de fútbol del Mundial de fútbol 2022, por ejemplo: Una clase que represente el Mundial, necesitaremos que contenga un listado de Selecciones, cada selección tendrá sus atributos, como nombre, país, jugadores, seleccionador, etc.

var teams = ["Qatar", "Ecuador", "Senegal", "Países Bajos", "Inglaterra", "Irán", "Estados Unidos", "Gales", "Argentina", "Arabia Saudí", "México", "Polonia", "Francia", "Australia", "Dinamarca", "Túnez", "España", "Costa Rica", "Alemania", "Japón", "Bélgica", "Canadá", "Marruecos", "Croacia", "Brasil", "Serbia", "Suiza", "Camerún", "Portugal", "Ghana", "Uruguay", "Corea del Sur"]

let nombresGrupos = ["A", "B", "C", "D", "E", "F", "G", "H"]

// Clase Mundial
class WorldCup {
    var groups = [Group]()
    var selecciones = [Team]()
    
    init (teamsStr: [String]){
        var listStr = teamsStr
        
        // Aquí creo la lista de selecciones
        for element in teamsStr {
            var equipo = Team(name: element)
            self.selecciones.append(equipo)
        }
        
        listStr.shuffle()
        while listStr.count > 3{
            if listStr.count%4 == 0 {
                var TeamA = Team(name: listStr.popLast() ?? "")
                var TeamB = Team(name: listStr.popLast() ?? "")
                var TeamC = Team(name: listStr.popLast() ?? "")
                var TeamD = Team(name: listStr.popLast() ?? "")
                self.groups.append(Group (name: "\n"+"GRUPO " + nombresGrupos[self.groups.count], teamA: TeamA, teamB: TeamB, teamC: TeamC, teamD: TeamD))
            }
        }
    }
    func getGroups(){
        groups.forEach { group in
            print(group.name.uppercased())
            group.equipos.forEach { team in
                print(team.name)
            }
        }
    }
}

//Clase Seleccion / Team
class Team {
    var name: String // propiedad pública
    var country: String = ""
    var players = [Player]()// propiedad pública
    var seleccionador: StaffMember
    var clasification = 0
    
    
    init(name: String) {
        self.name = name
        self.seleccionador = StaffMember(type: MemberType.seleccionador)
    }
}


// MARK: - EJERCICIO 7 -
// Crear una clase para representar los partidos entre selecciones, deberá contener atributos como equipo local, visitante y resultado como mínimo. Generar una lista aleatoria de partidos entre la lista de selecciones anteriores y hacer un print de este estilo por partido: Partido: España 3 - 1 Brasil

class Match {
    var localTeam: Team  // propiedad pública
    var visitorTeam: Team
    var goalsLocalTeam: Int = 0// propiedad pública
    var goalsVisitorTeam: Int = 0//
    var resultado = ""
    
    init(teamNameA: Team, teamName2: Team) {
        localTeam = teamNameA
        visitorTeam = teamName2
        resultado = playMatch()
    }
    
    func playMatch() -> String{
        self.goalsLocalTeam = getGoals()
        self.goalsVisitorTeam = getGoals()
        
        if(self.goalsLocalTeam > self.goalsVisitorTeam){
            self.localTeam.clasification = self.localTeam.clasification + 3
        }
        else if self.goalsLocalTeam == self.goalsVisitorTeam {
            self.localTeam.clasification = self.localTeam.clasification + 1
            self.visitorTeam.clasification = self.visitorTeam.clasification + 1
        }
        else if self.goalsLocalTeam < self.goalsVisitorTeam {
            self.visitorTeam.clasification = self.visitorTeam.clasification + 3
        }

        return ("Partido: \(self.localTeam.name) \(self.goalsLocalTeam) - \(self.goalsVisitorTeam) \(self.visitorTeam.name)")
    }
    func getGoals()-> Int{
        return Int.random(in: 0..<5)
    }
}

var teamsCopy = teams
var matchList = [Match]()

while teamsCopy.count > 1{
    teamsCopy.shuffle()
    var localTeam = Team(name: teamsCopy.popLast() ?? "")
    var visitorTeam = Team(name: teamsCopy.popLast() ?? "")
    matchList.append(Match(teamNameA: localTeam, teamName2: visitorTeam))

}
print("------------")
matchList.forEach { match in
    print(match.resultado)
}


// MARK: - EJERCICIO 8 -
//8.- Generar de forma aleatoria, dentro de la clase Mundial, un listado de grupos con un máximo de 4 selecciones por grupo, se puede crear una clase nueva Grupo que contenga el nombre del grupo, listado de participantes y listado de partidos. Por ejemplo: Grupo A España, Brasil, Francia, Alemania.

class Group {
    var name : String
    var equipos = [Team]()
    var partidos = [Match]()
    
    init(name : String, teamA: Team, teamB: Team, teamC: Team, teamD: Team) {
        self.name = name
        self.equipos.append(teamA)
        self.equipos.append(teamB)
        self.equipos.append(teamC)
        self.equipos.append(teamD)
        
        var teamsAlreadyIn = [String]()
        self.equipos.enumerated().forEach { index, team in
            self.equipos.forEach { otherTeam in
                if (team.name != otherTeam.name){
                    if !teamsAlreadyIn.contains(otherTeam.name) {
                        partidos.append(Match(teamNameA: team, teamName2: otherTeam))
                    }
                }
            }
            teamsAlreadyIn.append(team.name)
        }
    }
    
    func getListaPartidos() {
        print("-------------")
        self.partidos.forEach { match in
            print("partido: \(match.localTeam) - \(match.visitorTeam)")
        }
        print("-------------")
    }
    func getPunctuation(team: Team)-> Int{
        return team.clasification
    }
    func get2Classificates(teams: [Team]) {
        var classificated = [Team]()
        
        var kk = teams.sorted(by: { $0.clasification > $1.clasification })
        classificated.append(contentsOf: [kk[0], kk[1]])
        print ("Ganadores: ", classificated[0].name, "Puntuación: ",classificated[0].clasification, " - ", classificated[1].name, "Puntuación: ", classificated[1].clasification)
    }

}


var mundial2022 = WorldCup(teamsStr: teams)

mundial2022.groups.forEach { group in
    print(group.name, " RESULTADO PARTIDOS ------------------")
    group.partidos.forEach { team in
        print(team.resultado)
    }
    
    // MARK: -EJERCICIO 9-
    // 9.- Para añadir a cada Grupo los puntos de cada selección habrá que contabilizar las victorias con 3 puntos, empates con 1 y derrotas con 0. Añadir una función en la clase Grupo que le pasemos una selección y nos devuelva sus puntos.
    print("\(group.name) CLASIFICACIÓN --------------")
    group.equipos.forEach { team in
        print(team.name, group.getPunctuation(team: team))
    }
    
    // MARK: -EJERCICIO 10-
    // 10.- Generar los partidos del Mundial en cada grupo y calcular las dos primeras selecciones de cada grupo y hacer un print con los clasificados.
    print("\(group.name) CLASIFICADOS ---------------")
    group.get2Classificates(teams: group.equipos)
}

