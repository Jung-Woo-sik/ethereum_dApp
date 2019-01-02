pragma solidity ^0.4.17;

contract Adoption{
	event AddedStudent(uint studentId);
	struct TA{
		byte32 uid;
		uint TANum;
		bool doesExist;
	}
	sturct Student{
		byte32 studentId;
		byte32 party;
		uint score;
		bool doesExist;
	}
	address[16] public adopters;
	uint numStudent;
	mapping (uint => Student) student;
	mapping (uint => TA) TA;
	function addStudent(byte32 name, byte32 party) public{
		uint studentId = numStudent++;
		student[studentId] = Student(name,party,true);
		AddedStudent(studentId);
	}
	function scoring(byte32 uid, uint studentId, uint score) public{
		if (student[studentId].doesExist ==true && TA[uid].doesExist == true){
			student[studentId].score = score;
		}
	}

	function adopt(uint studentId) public returns (uint){
		require(studentId >= 0 && studentId <= 15);
		adopters[studentId] = msg.sender;

		return studentId;
	}

	function getAdopters() public view returns (address[16]){
		return adopters;
	}
	
	function getValue(uint studentId) public returns (uint){
		require(studentId >= 0 && studentId <=15);
		if(student[studentId].doesExist == true){
		adopters[studentId] = msg.sender;
		uint value = student[studentId].score;
		}
		return value;
	}
}
