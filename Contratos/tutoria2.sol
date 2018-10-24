pragma solidity ^0.4.7;
contract Tutoria {
    
    mapping (address => TutoriaData)  Tutorias;
    mapping (bytes32 => TutoriaData) TutoriasHash;
    
    struct TutoriaData {
        string materia;
        address idProfesor;
        address alumno;
        uint confirmado;
        uint cancelado;
        uint fecha;
        bytes32 hash;
    }

    function solicitar(string mater, address idProf) public returns (bytes32){
        bytes32 hashTemp = keccak256(mater,idProf,msg.sender,block.timestamp);
        require(msg.sender != idProf);
        TutoriaData t = Tutorias[msg.sender];
        t.materia = mater;
        t.idProfesor = idProf;
        t.alumno = msg.sender;
        t.confirmado = 0;
        t.cancelado = 0;
        t.fecha = block.timestamp;
        t.hash = hashTemp;
        //TutoriasHash[hashTemp]=t;
        return t.hash;
    }
    
    function getFecha(address key) public view returns (uint) {
        return Tutorias[key].fecha;
    }

    function getHash(address key) public view returns (bytes32) {
        return Tutorias[key].hash;
    }
    
    function getMateria(address key) public view returns (string) {
        return Tutorias[key].materia;
    }
    
    function getIdProfesor(address key) public view returns (address) {
        return Tutorias[key].idProfesor;
    }
    
    function getAlumno(address key) public view returns (address) {
        return Tutorias[key].alumno;
    }
    
    function confirmar(address key) public returns (uint) {
        require(Tutorias[key].idProfesor == msg.sender);
        require(Tutorias[key].confirmado == 0);
        require(Tutorias[key].cancelado == 0);
        return Tutorias[key].confirmado = 1;
    }
    
    function cancelar(address key) public returns (uint){

        require(Tutorias[key].alumno == msg.sender);
        require(Tutorias[key].confirmado == 0);
        require(Tutorias[key].cancelado == 0);
        return Tutorias[key].cancelado=1;
    }
    
    function estaConfirmado(address key) public view returns (uint){
        return Tutorias[key].confirmado;   
    }
    
    function estaCancelado(address key) public view returns (uint){
        return Tutorias[key].cancelado;
    }
    
}