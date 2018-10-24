pragma solidity ^0.4.7;
pragma experimental ABIEncoderV2;

contract Tutoria {
    
    mapping (uint => TutoriaData) Tutorias;
    
    
    struct TutoriaData {
        string materia;
        address idProfesor;
        address alumno;
        uint confirmado;
        uint cancelado;
        uint fecha;
        uint hash;
    }

    TutoriaData[] public tuto;

    function solicitar(string _materia, address _idProfesor) public returns (uint){
        uint hashTemp = uint(keccak256(msg.sender, _materia, _idProfesor, block.timestamp));
       //uint hashTemp = 123456;
        require(msg.sender != _idProfesor);
        TutoriaData t = Tutorias[hashTemp];
        t.materia = _materia;
        t.idProfesor = _idProfesor;
        t.alumno = msg.sender;
        t.confirmado = 0;
        t.cancelado = 0;
        t.fecha = block.timestamp;
        t.hash = hashTemp;
        return t.hash;
    }
    
   function getTutoria(uint key) public view returns (TutoriaData) {
        TutoriaData t = Tutorias[key];
        return t;
    }
    function getHash(uint key) public view returns (uint) {
        return Tutorias[key].hash;
    }
    
    function getMateria(uint key) public view returns (string) {
        return Tutorias[key].materia;
    }
    
    function getIdProfesor(uint key) public view returns (address) {
        return Tutorias[key].idProfesor;
    }
    
    function getAlumno(uint key) public view returns (address) {
        return Tutorias[key].alumno;
    }
    
    function confirmar(uint key) public returns (uint) {
        require(Tutorias[key].idProfesor == msg.sender);
        require(Tutorias[key].confirmado == 0);
        require(Tutorias[key].cancelado == 0);
        return Tutorias[key].confirmado = 1;
    }
    
    function cancelar(uint key) public returns (uint){

        require(Tutorias[key].alumno == msg.sender);
        require(Tutorias[key].confirmado == 0);
        require(Tutorias[key].cancelado == 0);
        return Tutorias[key].cancelado=1;
    }
    
    function estaConfirmado(uint key) public view returns (uint){
        return Tutorias[key].confirmado;   
    }
    
    function estaCancelado(uint key) public view returns (uint){
        return Tutorias[key].cancelado;
    }
    
}