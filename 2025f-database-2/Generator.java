
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Generator {

    private static final Random RNG = new Random();

    public static void main(String[] args) {
        int personnelCount = 20;
        List<Personnel> personnelList = generatePersonnel(personnelCount, 17);
        List<Vehicle> vehicleList = generateVehicles(personnelCount, 17, personnelCount);
        generatePersonnelOutput(personnelList);
        generateVehicleOutput(vehicleList);
        generateDeploymentsOutput(personnelList, vehicleList);
    }

    static class Personnel {

        int id;
        String firstName;
        String lastName;
        String personnelType;
        String serviceRank;
        int branchId;
        int commandId;
        int opBaseId;
        boolean isActive;
        Integer commandingOfficerId; // nullable
        int serviceYears;
        int deployed;
        double salary;

        Personnel(int id, String firstName, String lastName, String personnelType, String serviceRank,
                int branchId, int commandId, int opBaseId, boolean isActive, Integer commandingOfficerId,
                int serviceYears, int deployed, double salary) {
            this.id = id;
            this.firstName = firstName;
            this.lastName = lastName;
            this.personnelType = personnelType;
            this.serviceRank = serviceRank;
            this.branchId = branchId;
            this.commandId = commandId;
            this.opBaseId = opBaseId;
            this.isActive = isActive;
            this.commandingOfficerId = commandingOfficerId;
            this.serviceYears = serviceYears;
            this.deployed = deployed;
            this.salary = salary;
        }
    }

    static class Vehicle {

        int id;
        String sku;
        int branchId;
        int commandId;
        int opBaseId;
        boolean isActive;
        int responsiblePersonnelId;
        int serviceYears;
        int deployed;
        String purpose;
        double purchaseCost;
        double maintenanceCost;
        double yearlyDepreciation;
        double deploymentCost;

        Vehicle(int id, String sku, int branchId, int commandId, int opBaseId, boolean isActive,
                int responsiblePersonnelId, int serviceYears, int deployed, String purpose,
                double purchaseCost, double maintenanceCost, double yearlyDepreciation, double deploymentCost) {
            this.id = id;
            this.sku = sku;
            this.branchId = branchId;
            this.commandId = commandId;
            this.opBaseId = opBaseId;
            this.isActive = isActive;
            this.responsiblePersonnelId = responsiblePersonnelId;
            this.serviceYears = serviceYears;
            this.deployed = deployed;
            this.purpose = purpose;
            this.purchaseCost = purchaseCost;
            this.maintenanceCost = maintenanceCost;
            this.yearlyDepreciation = yearlyDepreciation;
            this.deploymentCost = deploymentCost;
        }
    }

    static List<Personnel> generatePersonnel(int count, int startId) {
        List<Personnel> list = new ArrayList<>();
        String[] types = {"Officer", "Enlisted"};
        String[] enlistedRanks = {"Private", "Private First Class", "Specialist", "Corporal", "Sergeant", "Staff Sergeant", "Sergeant First Class", "First Sergeant", "Sergeant Major"};
        String[] officerRanks = {"Second Lieutenant", "First Lieutenant", "Captain", "Major", "Lieutenant Colonel", "Colonel", "Brigadier General", "Major General", "Lieutenant General", "General"};
        String[] firstNames = {"Alex", "Taylor", "Jordan", "Morgan", "Casey", "Riley", "Jamie", "Drew", "Kris", "Avery"};
        String[] lastNames = {"Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Wilson", "Moore", "Taylor"};
        int branchCount = 6;
        int commandCount = 9;
        int opBaseCount = 10;

        for (int i = 0; i < count; i++) {
            int id = startId + i;
            String firstName = firstNames[RNG.nextInt(firstNames.length)];
            String lastName = lastNames[RNG.nextInt(lastNames.length)];
            String personnelType = types[RNG.nextInt(types.length)];

            String serviceRank;
            if ("Officer".equals(personnelType)) {
                serviceRank = officerRanks[RNG.nextInt(officerRanks.length)];
            } else {
                serviceRank = enlistedRanks[RNG.nextInt(enlistedRanks.length)];
            }

            int branchId = RNG.nextInt(branchCount) + 1;
            int commandId = RNG.nextInt(commandCount) + 1;
            int opBaseId = RNG.nextInt(opBaseCount) + 1;
            boolean isActive = true;

            // Assign null initially, will fix after loop
            Integer commandingOfficerId = null;

            int serviceYears = 1 + RNG.nextInt(20);
            int deployed = RNG.nextInt(8);
            double salary = 40000 + (serviceYears * 2000);

            list.add(new Personnel(id, firstName, lastName, personnelType, serviceRank, branchId, commandId,
                    opBaseId, isActive, commandingOfficerId, serviceYears, deployed, salary));
        }

        // Assign commanding officers after all personnel generated
        List<Integer> officerIds = new ArrayList<>();
        for (Personnel p : list) {
            if ("Officer".equals(p.personnelType)) {
                officerIds.add(p.id);
            }
        }
        for (Personnel p : list) {
            if ("Enlisted".equals(p.personnelType)) {
                List<Integer> possibleOfficers = new ArrayList<>();
                for (int officerId : officerIds) {
                    if (officerId < p.id) {
                        possibleOfficers.add(officerId);
                    }
                }
                if (!possibleOfficers.isEmpty()) {
                    p.commandingOfficerId = possibleOfficers.get(RNG.nextInt(possibleOfficers.size()));
                } else {
                    p.commandingOfficerId = null;
                }
            }
        }

        return list;
    }

    static List<Vehicle> generateVehicles(int count, int startId, int personnelCount) {
        List<Vehicle> list = new ArrayList<>();
        String[] purposes = {"combat", "transport", "patrol", "recon"};
        int branchCount = 6;
        int commandCount = 9;
        int opBaseCount = 10;

        for (int i = 0; i < count; i++) {
            int id = startId + i;
            String sku = "SKU-" + String.format("%03d", id);
            int branchId = RNG.nextInt(branchCount) + 1;
            int commandId = RNG.nextInt(commandCount) + 1;
            int opBaseId = RNG.nextInt(opBaseCount) + 1;
            boolean isActive = true;
            int responsiblePersonnelId = RNG.nextInt(personnelCount) + 1;
            int serviceYears = 1 + RNG.nextInt(15);
            int deployed = RNG.nextInt(7);
            String purpose = purposes[RNG.nextInt(purposes.length)];
            double purchaseCost = 50000 + (id * 50000);
            double maintenanceCost = 2000 + (i * 500);
            double yearlyDepreciation = purchaseCost * 0.1;
            double deploymentCost = 5000 + (i * 500);

            list.add(new Vehicle(id, sku, branchId, commandId, opBaseId, isActive, responsiblePersonnelId,
                    serviceYears, deployed, purpose, purchaseCost, maintenanceCost, yearlyDepreciation, deploymentCost));
        }
        return list;
    }

    static void generatePersonnelOutput(List<Personnel> personnelList) {
        for (Personnel p : personnelList) {
            System.out.printf(
                    "insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (%d, '%s', '%s', '%s', '%s', %d, %d, %d, %d, %s, %d, %d, %.2f),%n",
                    p.id, p.firstName, p.lastName, p.personnelType, p.serviceRank,
                    p.branchId, p.commandId, p.opBaseId, p.isActive ? 1 : 0,
                    p.commandingOfficerId == null ? "null" : p.commandingOfficerId.toString(),
                    p.serviceYears, p.deployed, p.salary
            );
        }
    }

    static void generateVehicleOutput(List<Vehicle> vehicleList) {
        for (Vehicle v : vehicleList) {
            System.out.printf(
                    "insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (%d, '%s', %d, %d, %d, %d, %d, %d, %d, '%s', %.2f, %.2f, %.2f, %.2f),%n",
                    v.id, v.sku, v.branchId, v.commandId, v.opBaseId, v.isActive ? 1 : 0,
                    v.responsiblePersonnelId, v.serviceYears, v.deployed, v.purpose,
                    v.purchaseCost, v.maintenanceCost, v.yearlyDepreciation, v.deploymentCost
            );
        }
    }

    static void generateDeploymentsOutput(List<Personnel> personnelList, List<Vehicle> vehicleList) {
        int deploymentId = 27;
        int personnelCount = personnelList.size();
        int vehicleCount = vehicleList.size();

        for (int i = 0; i < personnelCount; i++) {
            Personnel p = personnelList.get(i);
            Vehicle v1 = vehicleList.get(i % vehicleCount);
            Vehicle v2 = vehicleList.get((i + 1) % vehicleCount);

            System.out.printf("insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (%d, %d, %d, %d, %d, %d),%n",
                    deploymentId++, p.branchId, p.commandId, v1.id, p.id, p.opBaseId);

            System.out.printf("insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (%d, %d, %d, %d, %d, %d),%n",
                    deploymentId++, p.branchId, p.commandId, v2.id, p.id, p.opBaseId);
        }
    }
}
