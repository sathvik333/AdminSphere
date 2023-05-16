// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract StudentDetails {
    
    struct Student {
        string name;
        uint256 rollNo;
        uint256 marks;
        uint256 backlogs;
    }

    mapping (address => bool) public admins;
    mapping (address => Student) public students;
        
    constructor() {
        // admins[msg.sender] = true;
        admins[0x5D35ED1610EB7000131FD49EbaF423072476E7A8] = true;
    }
    
    modifier onlyAdmin() {
        require(admins[msg.sender], "Only admins can perform this action");
        _;
    }
    
    function addAdmin(address admin) public onlyAdmin {
        require(admin != address(0), "Invalid address");
        require(!admins[admin], "Address is already an admin");
        admins[admin] = true;
    }
    
    function removeAdmin(address admin) public onlyAdmin {
        require(admin != address(0), "Invalid address");
        require(admins[admin], "Address is not an admin");
        delete admins[admin];
    }
    
    function addStudent(string memory name, uint256 rollNo, uint256 marks, uint256 backlogs) public {
        require(msg.sender != address(0), "Invalid address");
        require(students[msg.sender].rollNo == 0, "Student already exists");
        students[msg.sender] = Student(name, rollNo, marks, backlogs);
    }
    
    function updateMarksAndBacklogs(uint256 marks, uint256 backlogs) public onlyAdmin{
        require(msg.sender != address(0), "Invalid address");
        require(students[msg.sender].rollNo != 0, "Student does not exist");
        students[msg.sender].marks = marks;
        students[msg.sender].backlogs = backlogs;
    }
    
    function getStudentDetails() public view returns (string memory name, uint256 rollNo, uint256 marks, uint256 backlogs) {
        require(msg.sender != address(0), "Invalid address");
        require(students[msg.sender].rollNo != 0, "Student does not exist");
        Student storage student = students[msg.sender];
        name = student.name;
        rollNo = student.rollNo;
        marks = student.marks;
        backlogs = student.backlogs;
    }
}
