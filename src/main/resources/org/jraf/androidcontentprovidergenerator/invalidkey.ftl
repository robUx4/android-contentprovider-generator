<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import org.gawst.asyncdb.InvalidDbEntry;
import org.gawst.asyncdb.InvalidEntry;

import android.support.annotation.NonNull;

public class ${entity.nameCamelCase}InvalidKey extends InvalidDbEntry {
    public ${entity.nameCamelCase}InvalidKey(@NonNull ${entity.nameCamelCase}Key key)throws InvalidDbEntry {
        super(getInvalidEntry(key));
    }

    private static InvalidEntry getInvalidEntry(@NonNull ${entity.nameCamelCase}Key key) throws InvalidDbEntry {
        final ${entity.nameCamelCase}Selection invalidSelection = new ${entity.nameCamelCase}Selection(key);
        return new InvalidEntry() {
            @Override
            public String[] getSelectArgs() {
                return invalidSelection.args();
            }
        };
    }
}
