import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;

/**
 * 
 * @author Alexandru Stefan Andries 20018146
 * @author Nicolò Benella 20018152
 *
 */
public class Rotate implements Transform {
	private BufferedImage source, result1, result2, empty;
	private double theta;
	private int Xc, Yc;
	private static double angle = 25;
	private static ImageIcon icon1, icon2;
	private int using = 1;
	
	private static String imageName = "Musician";

	public static void main(String[] args) throws InterruptedException {
		BufferedImage originalImage = null;
		try {
			originalImage = ImageIO.read(new File("images/" + imageName + ".jpg"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		// Carica immagine originale
		JLabel label = new JLabel(new ImageIcon(originalImage));
		JFrame f = new JFrame("Originalpicture");
		f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		f.getContentPane().add(label);
		f.pack();
		f.setLocation(20, 20);
		f.setVisible(true);
		Rotate myRotation = new Rotate();
		// Angolo iniziale
		myRotation.setRotationAngle(0);
		myRotation.setCenterPoint(originalImage.getWidth(), originalImage.getHeight());
		myRotation.setSourceData(originalImage);
		int newAngle = 0;
		//primo buffer da usare
		int using = 1;
		//icone create per evitare di farne di nuove ogni volta
		icon1 = new ImageIcon();
		icon2 = new ImageIcon();
		while (true) {
			// ruoto a valore precedente più angolo di ruotazione
			myRotation.setRotationAngle(newAngle);
			newAngle += angle;
			// ruota e aspetto
			myRotation.calculate();
			Thread.sleep(10);
			if(using == 1) {
				icon2.setImage((BufferedImage) myRotation.getResult());
				label.setIcon(icon2);
				using=2;
			}else {
				icon1.setImage((BufferedImage) myRotation.getResult());
				label.setIcon(icon1);
				using=1;
			}

		}
	}

	public void setRotationAngle(double ratio) {
		// Converto in radianti per usare gradi
		theta = Math.toRadians(ratio);
	}

	public void setCenterPoint(int Xcenter, int Ycenter) {
		// gets the center of the image
		Xc = Math.round(Xcenter / 2);
		Yc = Math.round(Ycenter / 2);
	}

	public void setSourceData(Object src) {
		source = (BufferedImage) src;
		result1 = new BufferedImage(source.getWidth(), source.getHeight(), source.getType());
		result2 = new BufferedImage(source.getWidth(), source.getHeight(), source.getType());
		empty = new BufferedImage(source.getWidth(), source.getHeight(), source.getType());
	}

	public void calculate() {
		
		// Devo resettare result perche dalla seconda volta in poi mi mantiene i dati della rotazione precedente
				if(using==1) {
					result2.setData(empty.getRaster());
				}else {
					result1.setData(empty.getRaster());
				}
		int x2, y2, X2R, Y2R;
		
		for (int band = 0; band < source.getRaster().getNumBands(); band++) {
			for (int x = 0; x < source.getWidth(); x++) {
				for (int y = 0; y < source.getHeight(); y++) {

					// prendo il valore da spostare con offset il punto centrale
					x2 = x - Xc;
					y2 = y - Yc;
					// calcolo la rotazione sul valore con offset
					X2R = (int) ((x2) * Math.cos(theta) + (y2) * Math.sin(theta));
					Y2R = (int) (-(x2) * Math.sin(theta) + (y2) * Math.cos(theta));
					// Sommo nuovamente l-offset al valore ruotato
					x2 = X2R + Xc;
					y2 = Y2R + Yc;

					// Controllo se out of bounds
					if (x2 < source.getWidth() && x2 >= 0) 
						if (y2 < source.getHeight() && y2 >= 0) 
							// Salvo il valore nel result
							if(using==1) {
								result2.getRaster().setSample(x, y, band, source.getRaster().getSample(x2, y2, band));
							}else {
								result1.getRaster().setSample(x, y, band, source.getRaster().getSample(x2, y2, band));
							}
				}
			}
		}

	}

	public Object getResult() {
		if(using==1) {
			using=2;
			return result2;
		}else {
			using=1;
			return result1;
		}
	}
}
