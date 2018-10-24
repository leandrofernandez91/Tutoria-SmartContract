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
        uint index;
    }

    TutoriaData[] public tuto;
    uint indice = 0;
    function solicitar(string _materia, address _idProfesor) public returns (uint){
        require(msg.sender != _idProfesor);
        uint resguardo = indice+1;
        TutoriaData t = Tutorias[resguardo];
        t.materia = _materia;
        t.idProfesor = _idProfesor;
        t.alumno = msg.sender;
        t.confirmado = 0;
        t.cancelado = 0;
        t.fecha = block.timestamp;
        t.index = resguardo;
        return indice++;
    }
    
   function getTutoria(uint key) public view returns (TutoriaData) {
        TutoriaData t = Tutorias[key];
        return t;
    }
    function getHash(uint key) public view returns (uint) {
        return Tutorias[key].index;
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
        TutoriaData t = Tutorias[key];
        return t.confirmado = 1;    
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