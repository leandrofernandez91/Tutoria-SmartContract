pragma solidity ^0.4.7;
contract Tutoria {
    
    mapping (address => TutoriaData)  Tutorias;
    
    
    struct TutoriaData {
        string materia;
        address idProfesor;
        address alumno;
        uint confirmado;
        uint cancelado;
        uint fecha;
        bytes32 hash;
    }
    
    function solicitar(string mater, address idProf) public{
        require(msg.sender != idProf);
        TutoriaData t = Tutorias[msg.sender];
        t.materia = mater;
        t.idProfesor = idProf;
        t.alumno = msg.sender;
        t.confirmado = 0;
        t.cancelado = 0;
        t.fecha = block.timestamp;
        t.hash = keccak256(t.materia,t.idProfesor,t.alumno,t.confirmado,t.cancelado,t.fecha);
    }
    
    function getFecha(address key) public view returns (uint) {
        TutoriaData t = Tutorias[key];
        return t.fecha;
    }

    function getHash(address key) public view returns (bytes32) {
        return Tutorias[key].hash;
    }
    
    function getMateria(address key) public view returns (string) {
        TutoriaData t = Tutorias[key];
        return t.materia;
    }
    
    function getIdProfesor(address key) public view returns (address) {
        TutoriaData t = Tutorias[key];
        return t.idProfesor;
    }
    
    function getAlumno(address key) public view returns (address) {
        TutoriaData t = Tutorias[key];
        return Tutorias[key].alumno;
    }
    
    function confirmar(address key) public returns (uint) {
        TutoriaData t = Tutorias[key];
        require(t.idProfesor == msg.sender);
        require(t.confirmado == 0);
        require(t.cancelado == 0);
        return t.confirmado = 1;
    }
    
    function cancelar(address key) public returns (uint) {
        TutoriaData t = Tutorias[key];
        require(t.alumno == msg.sender);
        require(t.confirmado == 0);
        require(t.cancelado == 0);
        t.cancelado=1;
        return t.cancelado;
    }
    
    function estaConfirmado(address key) public view returns (uint){
        TutoriaData t = Tutorias[key];
        return t.confirmado;   
    }
    
    function estaCancelado(address key) public view returns (uint){
        TutoriaData t = Tutorias[key];
        return t.cancelado;
    }
    
}