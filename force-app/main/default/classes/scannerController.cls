public class scannerController {
    public String[] codes { get; set; }
    public transient String code { get; set; }

    public scannerController() {
        codes = new String[0];
    }
    public void addCode() {
        codes.add(code);
    }
}