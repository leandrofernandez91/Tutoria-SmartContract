pragma solidity ^0.4.7;
contract Tutoria {
    struct tutoriaData{
        string materia;
        address idProfesor;
        address alumno;
    }

    tutoriaData[] public tuto;

    function pedir (string mater, address idProf) public{
        tutoriaData.materia = mater;
        tutoriaData.idProfesor = idProf;
        require(tutoriaData.idProf != msg.sender);
        tutoriaData.alumno = msg.sender;

    }
    mapping (address => tutoriaData) tutorias;
    function getMateria() public view returns (string) {
        return tutoriaData.materia;
    }

    function getIdProfesor() public view returns (address) {

        return tutoriaData.idProfesor;
    }

    function getAlumno() public view returns (address) {
        return tutoriaData.alumno;
    }

    function confirmar() public returns (uint) {
        return 0;
    }

    function cancelar() public returns (address) {

    }

    function esConfirmado() public returns (address) {

    }

    function estaConfirmado() public returns (address){

    }

}
