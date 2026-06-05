/**
 * Export utility module
 * Handles CSV and PDF export functionality
 */

import type { User, University, Filiere, Parcours, Testimonial, DashboardStats } from '@/types';

/**
 * Convert array of objects to CSV string
 */
export function convertToCSV(data: Array<Record<string, unknown>>, headers?: string[]): string {
  if (data.length === 0) return '';

  // Use provided headers or extract from first object
  const keys = headers || Object.keys(data[0]);
  
  // Create header row
  const csvHeaders = keys.join(',');
  
  // Create data rows
  const csvRows = data.map((row) =>
    keys.map((key) => {
      const value = row[key];
      // Handle values that contain commas, quotes, or newlines
      if (typeof value === 'string' && (value.includes(',') || value.includes('"') || value.includes('\n'))) {
        return `"${value.replace(/"/g, '""')}"`;
      }
      return value ?? '';
    }).join(',')
  );

  return [csvHeaders, ...csvRows].join('\n');
}

/**
 * Download CSV file
 */
export function downloadCSV(data: Array<Record<string, unknown>>, filename: string, headers?: string[]): void {
  const csv = convertToCSV(data, headers);
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
  const link = document.createElement('a');
  const url = URL.createObjectURL(blob);
  
  link.setAttribute('href', url);
  link.setAttribute('download', filename);
  link.style.visibility = 'hidden';
  
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
}

/**
 * Format data for CSV export from admin pages
 */
export function formatUsersForCSV(users: User[]): Record<string, unknown>[] {
  return users.map((user) => ({
    ID: user.id,
    Nom: user.name || `${user.prenom || ''} ${user.nom || ''}`.trim(),
    Email: user.email,
    Rôle: user.role,
    'Série Bac': user.serie || 'N/A',
    Tests: user.tests || 0,
    Statut: user.status,
    'Date Inscription': user.date,
  }));
}

export function formatUniversitiesForCSV(universities: University[]): Record<string, unknown>[] {
  return universities.map((uni) => ({
    ID: uni.id,
    Nom: uni.nom || uni.name,
    Type: uni.type === 'publique' ? 'Public' : 'Privé',
    Ville: uni.ville || uni.city,
    Email: uni.email_contact || uni.email || '',
    Téléphone: uni.telephone || uni.phone || '',
    'Site Web': uni.site_web || uni.website || '',
    'Coût Estimatif': uni.cout_estimatif || uni.costEstimate || '',
  }));
}

export function formatFilieresForCSV(filieres: Filiere[]): Record<string, unknown>[] {
  return filieres.map((fil) => ({
    ID: fil.id,
    Nom: fil.nom || fil.name,
    Domaine: fil.domaine || fil.domain || '',
    Niveau: fil.niveau || 'Licence',
    Université: fil.universite_nom || '',
    Durée: fil.duree_annees ? `${fil.duree_annees} ans` : '',
    'Difficulté': fil.difficulte || 'moyen',
    'Taux Emploi': fil.taux_emploi ? `${fil.taux_emploi}%` : '',
    'Salaire Moyen': fil.salaire_moyen_debutant || '',
  }));
}

export function formatParcoursForCSV(parcours: Parcours[]): Record<string, unknown>[] {
  return parcours.map((par) => ({
    ID: par.id,
    Nom: par.nom,
    Code: par.code || '',
    Filière: par.filiere_nom || '',
    Spécialisation: par.specialisation || '',
    Durée: par.duree_mois ? `${par.duree_mois} mois` : '',
    Description: par.description || '',
  }));
}

export function formatTestimonialsForCSV(testimonials: Testimonial[]): Record<string, unknown>[] {
  return testimonials.map((test) => ({
    ID: test.id,
    'Nom Étudiant': test.student_name,
    'Série Bac': test.student_serie || '',
    Université: test.university_name,
    Filière: test.course_name,
    Note: test.rating,
    Statut: test.status,
    Texte: test.text,
    Date: test.date || new Date().toLocaleDateString('fr-FR'),
  }));
}

/**
 * Generate a simple HTML report that can be printed as PDF
 */
export function generatePDFReport(
  title: string,
  data: Array<Record<string, unknown>>,
  columns: { key: string; label: string }[]
): string {
  const timestamp = new Date().toLocaleString('fr-FR');
  
  const htmlContent = `
    <!DOCTYPE html>
    <html lang="fr">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>${title}</title>
      <style>
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }
        
        body {
          font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
          padding: 40px;
          color: #1f2937;
          background: #f9fafb;
        }
        
        .header {
          text-align: center;
          margin-bottom: 30px;
          border-bottom: 2px solid #3b82f6;
          padding-bottom: 20px;
        }
        
        .header h1 {
          font-size: 28px;
          color: #1f2937;
          margin-bottom: 10px;
        }
        
        .header p {
          color: #6b7280;
          font-size: 12px;
        }
        
        .content {
          background: white;
          border-radius: 8px;
          padding: 20px;
          box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        table {
          width: 100%;
          border-collapse: collapse;
          margin-top: 20px;
        }
        
        th {
          background: #f3f4f6;
          padding: 12px;
          text-align: left;
          font-weight: 600;
          border-bottom: 2px solid #e5e7eb;
          font-size: 13px;
          color: #374151;
        }
        
        td {
          padding: 10px 12px;
          border-bottom: 1px solid #e5e7eb;
          font-size: 12px;
        }
        
        tr:last-child td {
          border-bottom: none;
        }
        
        tr:hover {
          background: #f9fafb;
        }
        
        .footer {
          margin-top: 30px;
          text-align: right;
          font-size: 11px;
          color: #9ca3af;
          border-top: 1px solid #e5e7eb;
          padding-top: 20px;
        }
        
        @media print {
          body {
            background: white;
            padding: 0;
          }
          
          .content {
            box-shadow: none;
            padding: 0;
          }
          
          table {
            page-break-inside: avoid;
          }
        }
      </style>
    </head>
    <body>
      <div class="header">
        <h1>${title}</h1>
        <p>Généré le ${timestamp}</p>
      </div>
      
      <div class="content">
        <p><strong>Total d'enregistrements :</strong> ${data.length}</p>
        
        <table>
          <thead>
            <tr>
              ${columns.map(col => `<th>${col.label}</th>`).join('')}
            </tr>
          </thead>
          <tbody>
            ${data.map(row => `
              <tr>
                ${columns.map(col => `<td>${row[col.key] ?? ''}</td>`).join('')}
              </tr>
            `).join('')}
          </tbody>
        </table>
      </div>
      
      <div class="footer">
        <p>Rapport Skill2Study - Plateforme d'orientation universitaire</p>
      </div>
    </body>
    </html>
  `;

  return htmlContent;
}

/**
 * Open PDF in new window for printing
 */
export function downloadPDF(
  title: string,
  data: Array<Record<string, unknown>>,
  columns: { key: string; label: string }[]
): void {
  const htmlContent = generatePDFReport(title, data, columns);
  const newWindow = window.open('', '_blank');
  
  if (newWindow) {
    newWindow.document.write(htmlContent);
    newWindow.document.close();
    
    // Wait a moment for the page to render, then print
    setTimeout(() => {
      newWindow.print();
    }, 250);
  }
}

/**
 * Export stats summary
 */
export function exportStatsSummary(stats: any, filename: string = 'statistics.csv'): void {
  const data = [
    { Métrique: 'Utilisateurs inscrits', Valeur: stats.totalUsers || 0 },
    { Métrique: 'Tests complétés', Valeur: stats.totalRecommendations || 0 },
    { Métrique: 'Filières disponibles', Valeur: stats.totalFilieres || 0 },
    { Métrique: 'Universités', Valeur: stats.totalUniversities || 0 },
    { Métrique: 'Taux de satisfaction', Valeur: `${stats.tauxCompatibiliteMoyen || 0}%` },
  ];
  
  downloadCSV(data, filename);
}
